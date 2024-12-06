// features/quran/presentation/page/views/quran_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/custom_widget/bg_cliprect.dart';
import 'package:islami/core/custom_widget/bg_image.dart';
import 'package:islami/core/custom_widget/bg_positioned.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/quran/presentation/page/views/aya_of_the_day.dart';
import 'package:islami/features/quran/presentation/page/views/surah_details.dart';
import 'package:islami/features/quran/presentation/page/widgets/read_bar_text.dart';
import 'package:islami/features/quran/presentation/page/widgets/recently_read.dart';
import 'package:islami/features/quran/presentation/page/widgets/search_textfield.dart';
import 'package:islami/features/quran/data/repo/quran_service.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/model/recieve/ayah_of_the_day/aya_of_the-day.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late TextEditingController searchController;
  List<dynamic> filteredSurahs = [];
  List<dynamic> allSurahs = [];

  @override
  void initState() {
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        filteredSurahs =
            QuranService.filterSurahs(searchController.text, allSurahs);
      });
    });
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    await QuranService.getAyah();
    setState(() {
      allSurahs = QuranService.data["surahs"];
      filteredSurahs = allSurahs;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var mediaquery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingProvider>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          ///////////////////////////////////////////////////bg image
          BgImage(
            image: AppImages.layoutBgPng,
          ),
          const BgCliprect(),
          const BgPositioned(),

          ///////////////////////////////////////////////////////////body
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaquery.width * .02),
            child: Column(
              children: [
                Gap(mediaquery.height * .1),
                SvgPicture.asset(AppImages.Islami_logo_textSvg),
                TextButton(onPressed: () => pushTo(context,const AyaScreen()), child:const Text("")),

                ////////////////////////////////////////////search bar
                Gap(mediaquery.height * .03),

                SearchTextfield(
                    hinttext: locale.search_surah_name,
                    searchController: searchController),

                ////////////////////////////////////////////read bar text
                Gap(mediaquery.height * .03),
                const ReadBarText(),
                //////////////////////////////////////////read container
                Gap(mediaquery.height * .03),
                AppLocalStorage.getCachedData(AppLocalStorage.nameKey) == null
                    ? Center(
                        child: Text(
                          locale.there_is_no_surah_readed_yet,
                          style: gettitleTextStyle20(),
                        ),
                      )
                    : SizedBox(
                        height: mediaquery.height * .15,
                        width: mediaquery.width * .8,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: vm.isDark()
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor,
                              ),
                              child: const Stack(
                                children: [
                                  ////recently added container
                                  RecentlyRead(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                /////////////////////////////////////////////text
                const Gap(20),

                Row(
                  children: [
                    Text(
                      locale.suras_list,
                      style: gettitleTextStyle20(
                        color: vm.isDark()
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                //////////////////////////////////////////////////surah list
                filteredSurahs.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                          color: vm.isDark()
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: filteredSurahs.length,
                          itemBuilder: (context, index) {
                            var fromData = filteredSurahs[index];
                            var arabicName = fromData["name"];
                            var englishName = fromData["englishName"];
                            var suraNumber = fromData["number"].toString();

                            int surahlength =
                                getVerseCount((int.parse(suraNumber)));

                            List<String> ayahsText = List.generate(
                              surahlength,
                              (index) => getVerse(
                                int.parse(suraNumber),
                                index + 1,
                              ),
                            );
                            return ListTile(
                              onTap: () {
                                AppLocalStorage.cachedData(
                                    AppLocalStorage.suraArabicKey, arabicName);
                                AppLocalStorage.cachedData(
                                    AppLocalStorage.nameKey, englishName);
                                AppLocalStorage.cachedData(
                                    AppLocalStorage.suranNumber,
                                    getVerseCount(index + 1).toString());
                                pushTo(
                                  context,
                                  SurahDetails(
                                    suraNameAR: arabicName,
                                    suraNameEN: englishName,
                                    suranum: ayahsText.toString(),
                                  ),
                                  //content: Text('Surah: ${surah["name"]}, Ayah: ${ayah["number"]}'),
                                );
                              },
                              leading: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Text(
                                    suraNumber,
                                    style: gettitleTextStyle18(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SvgPicture.asset(AppImages.surah_vectorSvg),
                                ],
                              ),
                              title: Text(
                                englishName,
                                style: gettitleTextStyle20(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              subtitle: Text(
                                  "${getVerseCount(index + 1).toString()}  ${locale.verses}",
                                  style: gettitleTextStyle16(
                                      color: AppColors.whiteColor)),
                              trailing: Text(
                                arabicName,
                                style: gettitleTextStyle20(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              endIndent: mediaquery.width * .1,
                              indent: mediaquery.width * .1,
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
