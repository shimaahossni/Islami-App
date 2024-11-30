// core/custom_widget/bg_positioned.dart
import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_images.dart';

class BgPositioned extends StatelessWidget {
  const BgPositioned({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Positioned(
      left: mediaquery.width * .1,
      child: Image.asset(
        AppImages.decorate_bgPng,
        width: mediaquery.height / 2.8,
      ),
    );
  }
}
