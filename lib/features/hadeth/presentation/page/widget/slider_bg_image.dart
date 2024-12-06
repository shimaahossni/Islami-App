// features/hadeth/page/widget/slider_bg_image.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';

class SliderBgImage extends StatelessWidget {
  const SliderBgImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.onboardPng3,
      color: AppColors.blackColor.withOpacity(.2),
    );
  }
}
