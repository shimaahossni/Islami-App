// features/setting/page/views/setting_screen.dart
import 'dart:ui';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/custom_widget/bg_cliprect.dart';
import 'package:islami/core/custom_widget/bg_image.dart';
import 'package:islami/core/custom_widget/bg_positioned.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/functions/theme.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<String> languageList = ['English', 'عربي'];

  final List<String> themeList = ['light', 'dark'];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //////////////////////////////////////////////////////////bg
          BgImage(
            image: AppImages.seb7aPng,
          ),
          const BgCliprect(),
          const BgPositioned(),
          /////////////////////////////////////////////////////////////body content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      locale.language,
                      style: gettitleTextStyle24(
                        color: vm.isDark()
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height * .02,
                ),
                /////////////////////////////////////language dropdownlist

                CustomDropdown<String>(
                  items: languageList,
                  initialItem: vm.currentLanguage == 'en' ? "English" : "عربي",
                  decoration: CustomDropdownDecoration(
                    expandedFillColor: vm.isDark()
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    closedFillColor: vm.isDark()
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    closedSuffixIcon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: vm.isDark() ? Colors.white : Colors.black,
                    ),
                    expandedSuffixIcon: Icon(
                      Icons.keyboard_arrow_up_sharp,
                      color: vm.isDark() ? Colors.white : Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    if (value == 'English') {
                      vm.changeLanguage('en');
                    } else if (value == "عربي") {
                      vm.changeLanguage('ar');
                    }
                  },
                ),
                Gap(
                  mediaQuery.height * .07,
                ),
                Row(
                  children: [
                    Text(
                      locale.themeMode,
                      style: gettitleTextStyle24(
                        color:
                            vm.isDark() ? Colors.white : AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                /////////////////////////////////////////////////theme
                CustomDropdown<String>(
                  items: themeList,
                  initialItem: vm.isDark() ? 'dark' : 'light',
                  decoration: CustomDropdownDecoration(
                    expandedFillColor: vm.isDark()
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    closedFillColor: vm.isDark()
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    closedSuffixIcon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: vm.isDark() ? Colors.white : Colors.black,
                    ),
                    expandedSuffixIcon: Icon(
                      Icons.keyboard_arrow_up_sharp,
                      color: vm.isDark() ? Colors.white : Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    if (value == 'light') {
                      vm.changeTheme(ThemeMode.light);
                    } else if (value == "dark") {
                      vm.changeTheme(ThemeMode.dark);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
