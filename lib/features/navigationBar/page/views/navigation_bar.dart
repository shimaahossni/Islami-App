// features/navigationBar/page/views/navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_icons.dart';
import 'package:islami/features/hadeth/page/views/hadeth_screen.dart';
import 'package:islami/features/prayerTime/page/views/prayer_time_screen.dart';
import 'package:islami/features/quran/page/views/quran_screen.dart';
import 'package:islami/features/seb7a/page/views/seb7a_screen.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:islami/features/setting/page/views/setting_screen.dart';
import 'package:islami/features/today_werd/page/views/today_werd.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int currentIndex = 3;
  List<Widget> screens = [
    const QuranScreen(),
    HadethScreen(),
    const SebhaScreen(),
    const PrayerTimeScreen(),
    const TodayWerd(),
    const SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    ////////change lang
    var lang = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          currentIndex = index;

          setState(() {});
          ///////////////////change button color
        },
        backgroundColor:
            vm.isDark() ? AppColors.primaryColor : AppColors.whiteColor,
        items: [
          //////////////////////////////////////////////quran icon
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.bookSvg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.bookSvg,
                  colorFilter: ColorFilter.mode(
                    vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor,
                    BlendMode.srcIn,
                  )),
              label: lang.quran),

          /////////////////////////////////////////hadeth icon
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.vectorSvg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.vectorSvg,
                  colorFilter: ColorFilter.mode(
                    vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor,
                    BlendMode.srcIn,
                  )),
              label: lang.hadith),

          //////////////////////////////////////////////sebha
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.seb7aSvg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.seb7aSvg,
                  colorFilter: ColorFilter.mode(
                    vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor,
                    BlendMode.srcIn,
                  )),
              label: lang.sebha),

          //////////////////////////////////////////////prayer
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.Vector1Svg,
              ),
              activeIcon: SvgPicture.asset(AppIcons.Vector1Svg,
                  colorFilter: ColorFilter.mode(
                    vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor,
                    BlendMode.srcIn,
                  )),
              label: lang.prayer),

          ////////////////////////////////////////////werd
          BottomNavigationBarItem(
              icon: const Icon(Icons.alarm_on_sharp), label: lang.werd),

          ////////////////////////////////////////////settings
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: lang.settings),
        ],

        ///////////////////////////////////////////////selected Item
        selectedItemColor:
            vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor,
        selectedLabelStyle: gettitleTextStyle14(
          color: vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor,
        ),

        /////////////////////////////////////////////unselected Item
        showUnselectedLabels: false,
      ),
    );
  }
}
