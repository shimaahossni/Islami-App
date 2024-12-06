// features/today_werd/presentation/widget/custom_button.dart
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.bgcolor,
      this.textcolor,
      this.width,
      this.height,
      required this.text,
      required this.onPressed});

  Color? bgcolor;
  Color? textcolor;
  double? width;
  double? height;
  String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              //horizontal: width ?? mediaquery.width * .05,
              vertical: height ?? mediaquery.height * .02),
          backgroundColor: bgcolor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      // onPressed:(){},
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: textcolor ?? AppColors.whiteColor,
            fontSize: mediaquery.width * .05),
      ),
    );
  }
}
