// features/hadeth/page/widget/slider_bg_pos_three.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';

class SliderBgPosThree extends StatelessWidget {
  const SliderBgPosThree({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Positioned(
      top: 10,
      left: mediaquery.width * .5,
      child: Image.asset(
        scale: 3.5,
        AppImages.mask2Png,
        color: AppColors.blackColor,
      ),
    );
  }
}
