// features/hadeth/page/widget/slider_bg_pos_one.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';

class SliderBgPosOne extends StatelessWidget {
  const SliderBgPosOne({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Positioned(
        bottom: 0,
        child: Image.asset(
          AppImages.Mask1Png,
          width: mediaquery.width / 1.2,
          color: AppColors.blackColor.withOpacity(.5),
        ));
  }
}
