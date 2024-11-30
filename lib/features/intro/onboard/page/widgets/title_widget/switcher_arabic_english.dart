// features/intro/onboard/page/widgets/title_widget/switcher_arabic_english.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SwitcherArabicEnglish extends StatelessWidget {
  const SwitcherArabicEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingProvider>(context);

    return ToggleSwitch(
      minWidth: mediaquery.width * .2,
      minHeight: mediaquery.width * .1,
      initialLabelIndex: 0,
      cornerRadius: 10.0,
      activeFgColor: Colors.black,
      ////inactive
      inactiveBgColor:
          vm.currentLanguage == 'en' ? Colors.grey : AppColors.primaryColor,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      icons: vm.currentLanguage == 'en'
          ? const [FontAwesomeIcons.globe, FontAwesomeIcons.language]
          : const [FontAwesomeIcons.globe, FontAwesomeIcons.language],
      iconSize: 20.0,
      /////////////////////////////active color
      activeBgColors: vm.currentLanguage == 'en'
          ? const [
              [
                AppColors.primaryColor,
              ],
              [
                AppColors.primaryColor,
              ]
            ]
          : const [
              [
                Colors.grey,
                Colors.grey,
              ],
            ],
      animate: true,
      curve: Curves.bounceInOut,
      onToggle: (index) {
        print('switched to: $index');

        index == 0 ? vm.changeLanguage('en') : vm.changeLanguage('ar');
      },
    );
  }
}
