// features/prayerTime/presentation/page/views/prayer_time_screen.dart
import 'dart:math';
import 'dart:ui';
import 'package:adhan/adhan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islami/core/custom_widget/bg_cliprect.dart';
import 'package:islami/core/custom_widget/bg_image.dart';
import 'package:islami/core/custom_widget/bg_positioned.dart';
import 'package:islami/core/functions/adhan.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/functions/notification.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/prayerTime/presentation/page/views/evening_screen_another.dart';
import 'package:islami/features/prayerTime/presentation/page/widget/azkar_gridview.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  //adhan and location services

  String? _currentAddress;
  Position? _currentPostion;

  Future<bool> _handleLocationPersmission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enable Location service')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location service is denied')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPersmission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPostion = position);
      _getAddressFromLatLng(_currentPostion!);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPostion!.latitude, _currentPostion!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street} '
            ',${place.subLocality} ,${place.country}  ,${place.postalCode} ';
      });
    }).catchError((e) {
      print(e);
    });
  }

  //////////////////////////////////qiblah
  double? heading = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();

    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var mediaquery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingProvider>(context);

    List<String> gridviewAzkari = [
      (local.evening_azkar),
      (local.sleeping_azkar),
      (local.morning_azkar),
      //'Morning Azkar'
    ];

    //////////////////////////////////////////////////////////adhan package
    final myCoordinates = Coordinates(
        _currentPostion?.latitude ?? 0, _currentPostion?.longitude ?? 0);

    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    final latPosition = _currentPostion?.latitude ?? 0;
    final longPosition = _currentPostion?.longitude ?? 0;
    final accPosition = _currentPostion?.accuracy ?? 0;
    final altPosition = _currentPostion?.altitude ?? 0;
    final spePosition = _currentPostion?.speed ?? 0;
    final currentAddress = _currentAddress ?? "";
    // print(currentAddress);

    ///////////////////////////////////////////////////list
    final fajr = DateFormat.jm().format(prayerTimes.fajr);
    final dhuhr = DateFormat.jm().format(prayerTimes.dhuhr);
    final asr = DateFormat.jm().format(prayerTimes.asr);
    final maghrib = DateFormat.jm().format(prayerTimes.maghrib);
    final isha = DateFormat.jm().format(prayerTimes.isha);
    List<String> prayerTimesList = [fajr, dhuhr, asr, maghrib, isha];
    List<String> prayerTimesName = [
      (local.fajr),
      (local.dhuhr),
      (local.asr),
      (local.maghrib),
      (local.isha)
    ];

    String date = DateFormat.EEEE().format(DateTime.now());
    String date2 = DateFormat.y().format(DateTime.now());
    String date3 = DateFormat.MMMd().format(DateTime.now());
    var _today = HijriCalendar.now();

    return Scaffold(
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          ///////////////////////////////////////////////////bg image
          BgImage(
            image: AppImages.prayer_time_bgPng,
          ),
          const BgCliprect(),
          const BgPositioned(),

          ////////////////////////////////////////////////////////////////////////////////body
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(mediaquery.height * .12),
                SvgPicture.asset(AppImages.Islami_logo_textSvg),

                //////////////////////////////////prayer time container

                Gap(mediaquery.height * .02),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: mediaquery.width * .02),
                  child: Container(
                    width: double.infinity,
                    height: mediaquery.height / 3,
                    decoration: BoxDecoration(
                      color: vm.isDark()
                          ? AppColors.sliderContainerColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          AppImages.prayerSliderPng,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: [
                            //////////////////////////////////////prayer date and time hijri and meladi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "$date3 ,\n$date2",
                                  style: gettitleTextStyle16(
                                    color: vm.isDark()
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                  ),
                                ),
                                Text(
                                  "${local.prayer} ${local.time}\n$date",
                                  style: gettitleTextStyle20(
                                      color: vm.isDark()
                                          ? AppColors.blackColor
                                          : AppColors.whiteColor),
                                ),
                                Text(
                                  "${_today.hDay} ${_today.getShortMonthName()},\n${_today.hYear}",
                                  style: gettitleTextStyle16(
                                    color: vm.isDark()
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                  ),
                                ),
                              ],
                            ),

                            /////////////////////////////////////////////////////slider from adhan package
                            Gap(mediaquery.height * .03),
                            CarouselSlider.builder(
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index,
                                  int realIndex) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: mediaquery.width * .02),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: const Alignment(0.8, 1),
                                        colors: vm.isDark()
                                            ? <Color>[
                                                Colors.white,
                                                const Color(0xff202020),
                                                const Color(0xffB19768),
                                              ]
                                            : <Color>[
                                                const Color(0xff202020),
                                                const Color(0xffB19768),
                                                Colors.white,
                                              ],
                                        tileMode: TileMode.mirror,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          prayerTimesName[index],
                                          style: gettitleTextStyle18(
                                              color: AppColors.whiteColor),
                                        ),
                                        Text(
                                          prayerTimesList[index],
                                          style: gettitleTextStyle30(
                                              color: AppColors.whiteColor),
                                        ),
                                      ],
                                    ));
                              },
                              options: CarouselOptions(
                                height: mediaquery.height / 5,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.4,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ////////////////azkar text
                Gap(mediaquery.height * .02),
                Row(
                  children: [
                    Gap(mediaquery.width * .04),
                    Text(
                      local.azkar,
                      style: gettitleTextStyle24(color: AppColors.whiteColor),
                    ),
                    Gap(mediaquery.height * .02),
                  ],
                ),

                /////////////////////////////////////////////////////////////////gridview azkar
                Gap(mediaquery.height * .02),
                Container(
                  width: mediaquery.width * .95,
                  height: mediaquery.height * .3,
                  decoration: BoxDecoration(
                    color: vm.isDark()
                        ? AppColors.sliderContainerColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                    ),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          pushTo(
                              context,
                              EveningScreenAnother(
                                pageNumber: index,
                              ));
                        },
                        child: AzkarGridview(
                          text: gridviewAzkari[index],
                          image: AppImages.azkar1Png,
                        ),
                      );
                    },
                  ),
                ),

                /////////////////////////////////qiblah
                Gap(mediaquery.height * .03),
                Row(
                  children: [
                    Gap(mediaquery.width * .04),
                    Text(
                      local.qiblah,
                      style: gettitleTextStyle24(color: AppColors.whiteColor),
                    ),
                  ],
                ),

                Gap(mediaquery.height * .02),
                Column(
                  children: [
                    Text(
                      "${heading!.ceil()} ",
                      style: gettitleTextStyle16(),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImages.qiblaPng,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Transform.rotate(
                          angle: ((heading ?? 0) * (pi / 180) * -1),
                          child: Image.asset(
                            AppImages.needlePng,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
