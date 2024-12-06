// features/quran/page/views/surah_details.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/color_four_lines.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_fonts.dart';
import 'package:islami/core/utils/app_images.dart';
import 'dart:math';

import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class SurahDetails extends StatelessWidget {
  const SurahDetails({
    super.key,
    required this.suranum,
    required this.suraNameAR,
    required this.suraNameEN,
  });
  final String suranum;
  final String suraNameAR;
  final String suraNameEN;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingProvider>(context);

    String x = suranum.replaceAll(', ', ',\n');
    String y = x.replaceAll('[', ' ');
    String finalText = y.replaceAll(']', '');
    List<String> substrings = finalText.split(',');

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        foregroundColor: AppColors.primaryColor,
        backgroundColor: vm.isDark()
            ? AppColors.blackColor
            : AppColors.whiteColor.withOpacity(.2),
        title: Text(
          suraNameEN,
          style: gettitleTextStyle20(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          vm.isDark()
              ? Image.asset(
                  AppImages.SouraDetailsScreenPng,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  AppImages.SouraDetailsScreenPng,
                  color: AppColors.whiteColor.withOpacity(.4),
                  fit: BoxFit.cover,
                ),
          Positioned(
              top: mediaquery.height * .05,
              //left: mediaquery.width * .4,
              child: Text(
                suraNameAR,
                style: gettitleTextStyle24(),
              )),
          Column(
            children: [
              Gap(mediaquery.height * .04),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: mediaquery.width * .05,
                  vertical: mediaquery.height * .08,
                ),
                height: mediaquery.height / 1.55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primaryColor, width: 1.5),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Gap(mediaquery.height * .02),
                        SizedBox(
                          height: mediaquery.height * .62,
                          width: mediaquery.width * .8,
                          child: ListView.builder(
                            itemCount: substrings.length,
                            itemBuilder: (context, index) {
                              final randomColors = List.generate(
                                substrings.length,
                                (index) => Color((Random().nextDouble() *
                                            AppColors.primaryColor.value)
                                        .toInt())
                                    .withOpacity(1.0),
                              );
                              return Column(
                                children: [
                                  Gap(mediaquery.height * .01),
                                  Text.rich(
                                    buildColoredLine(
                                        substrings[index], randomColors[index]),
                                    style: const TextStyle(
                                      fontFamily: AppFonts.fontFamily,
                                      //fontSize: 10,
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
