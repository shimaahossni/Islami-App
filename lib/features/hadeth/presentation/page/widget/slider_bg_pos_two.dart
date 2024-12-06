// features/hadeth/page/widget/slider_bg_pos_two.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';

class SliderBgPosTwo extends StatelessWidget {
  const SliderBgPosTwo({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Positioned(
      top: 10,
      right: mediaquery.width * .5,
      child: Image.asset(
        scale: 3.5,
        AppImages.MaskPng,
        color: AppColors.blackColor,
      ),
    );
  }
}
