// features/quran/page/widgets/recently_read.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecentlyRead extends StatelessWidget {
  const RecentlyRead({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Gap(mediaquery.width * .03),

          //column text
          Padding(
            padding: EdgeInsets.only(
              top: mediaquery.height * .03,
              left: mediaquery.width * .03,
              right: mediaquery.width * .03,
            ),
            child: Column(
              children: [
                Text(AppLocalStorage.getCachedData(AppLocalStorage.nameKey),
                    style: gettitleTextStyle24(color: AppColors.blackColor)),
                Text(
                    AppLocalStorage.getCachedData(
                        AppLocalStorage.suraArabicKey),
                    style: gettitleTextStyle24(color: AppColors.blackColor)),
                Text(
                    "${AppLocalStorage.getCachedData(AppLocalStorage.suranNumber)} ${locale.verses}",
                    style: gettitleTextStyle14(color: AppColors.blackColor)),
              ],
            ),
          ),
          //image
          Image.asset(
            AppImages.quranReadPng,
            color: AppColors.blackColor,
          ),
          Gap(mediaquery.width * .03),
        ],
      ),
    );
  }
}
