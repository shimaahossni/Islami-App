// features/seb7a/page/views/seb7a_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/custom_widget/bg_cliprect.dart';
import 'package:islami/core/custom_widget/bg_image.dart';
import 'package:islami/core/custom_widget/bg_positioned.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  double _rotationAngle = 0.0;
  var counter = 0;
  var currentindex = 0;
  var x, y, z;

  void _rotateImage() {
    setState(() {
      counter++;
      _rotationAngle += 45.0;
      // Check if counter has reached 99 degrees return to 0
      counter == 100 ? counter = 0 : counter;
      if (counter < 30) {
        x = AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey.toString(), counter.toString());
        currentindex = 0;
      } else if (counter < 60 && counter > 30) {
        y = AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey.toString(), counter.toString());
        currentindex = 1;
      } else if (counter < 90 && counter > 60) {
        z = AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey.toString(), counter.toString());
        currentindex = 2;
      } else {
        AppLocalStorage.cachedSebhaData(
            AppLocalStorage.sebhaKey.toString(), counter.toString());
        currentindex = 0;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);

    List<String> changeTasbeh = [
      "${local.sobhan_allah}",
      "${local.sobhan_allah_wbehamdih}",
      "${local.alhamdulillah}",
    ];

    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ///////////////////////////////////////////////////bg image
            BgImage(
              image: AppImages.seb7aPng,
            ),
            const BgCliprect(),
            const BgPositioned(),

            ////////////////////////////////////////////////////////////////page content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///////////////////////////////////////logo
                  SvgPicture.asset(AppImages.Islami_logo_textSvg),
                  const Gap(30),

                  ///////////////////////////////////////title

                  Text(
                    "${local.sabeh} ${local.esm} ${local.rabik} ${local.alahla}",
                    style: gettitleTextStyle36(
                        color: vm.isDark()
                            ? AppColors.whiteColor
                            : AppColors.whiteColor),
                  ),
                  const Gap(20),

                  ///////////////////////////////////////seb7a body

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(50),
                      Image.asset(
                        AppImages.upPng,
                        width: 70,
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                          onTap: _rotateImage,
                          child: Transform.rotate(
                            angle:
                                _rotationAngle * (3.1415926535897932 / 180.0),
                            child: SvgPicture.asset(
                              AppImages.SebhaBodySvg,
                              width: mediaquery.width * .8,
                            ),
                          )),
                      Column(
                        children: [
                          SizedBox(
                            width: mediaquery.width * .55,
                            child: Text(
                              changeTasbeh[currentindex],
                              style: gettitleTextStyle36(
                                  color: vm.isDark()
                                      ? AppColors.whiteColor
                                      : Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            AppLocalStorage.getCachedSebhaData(
                                        AppLocalStorage.sebhaKey) ==
                                    null
                                ? "0"
                                : "${AppLocalStorage.getCachedSebhaData(AppLocalStorage.sebhaKey)}",
                            style: gettitleTextStyle36(
                                color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
