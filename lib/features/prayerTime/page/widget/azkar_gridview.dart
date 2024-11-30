// features/prayerTime/page/widget/azkar_gridview.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';

class AzkarGridview extends StatelessWidget {
  AzkarGridview({super.key, required this.text, required this.image});

  String text;
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.blackColor,
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(image)),
          Text(
            text,
            style: gettitleTextStyle16(color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}
