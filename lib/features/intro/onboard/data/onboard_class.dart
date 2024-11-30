// features/intro/onboard/data/onboard_class.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/intro/onboard/page/widgets/description_widget/des_four.dart';
import 'package:islami/features/intro/onboard/page/widgets/description_widget/des_one.dart';
import 'package:islami/features/intro/onboard/page/widgets/description_widget/des_three.dart';
import 'package:islami/features/intro/onboard/page/widgets/description_widget/des_two.dart';
import 'package:islami/features/intro/onboard/page/widgets/title_widget/onboard_five.dart';
import 'package:islami/features/intro/onboard/page/widgets/title_widget/onboard_four.dart';
import 'package:islami/features/intro/onboard/page/widgets/title_widget/onboard_one.dart';
import 'package:islami/features/intro/onboard/page/widgets/title_widget/onborad_three.dart';
import 'package:islami/features/intro/onboard/page/widgets/title_widget/onborad_two.dart';
import 'package:islami/features/intro/onboard/page/widgets/title_widget/switcher_arabic_english.dart';

class onBoardClass {
  String title;
  String centerImage;
  String? content;
  Widget? contentWidget;
  Widget? description;
  Widget? descriptionText;

  onBoardClass({
    required this.title,
    required this.centerImage,
    this.content,
    this.contentWidget,
    this.description,
    this.descriptionText,
  });
}

List<onBoardClass> onboardContents = [
  ///////////////////////////
  /////////////////////////////////////first onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng1,
    // content: "Chose Language",
    contentWidget: OnboardOne(),
    //description: ArabicEnglishContainer(),
    description: SwitcherArabicEnglish(),
  ),

  /////////////////////////////////////////////////////////////second onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng2,
    // content: "Welcome To Islami",
    contentWidget: OnboradTwo(),
    descriptionText: DesOne(),
  ),

  /////////////////////////////////////////////////////////////third onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng3,
    //content: "Reading the Quran",
    contentWidget: OnboradThree(),
    descriptionText: DesTwo(),
  ),

  ///////////////////////////////////////////////////////////fourth onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng4,
    // content: "Bearish",
    contentWidget: OnboardFour(),
    descriptionText: DesThree(),
  ),

  ///////////////////////////////////////////////////////////fifth onboard page
  onBoardClass(
    title: AppImages.Islami_logo_textSvg,
    centerImage: AppImages.onboardPng5,
    // content: "Holy Quran ",
    contentWidget: OnboardFive(),
    descriptionText: DesFour(),
  ),
];
