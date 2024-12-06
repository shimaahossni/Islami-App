// features/intro/onboard/page/widgets/onborad_three.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/core/functions/text_font.dart';

class OnboradThree extends StatelessWidget {
  const OnboradThree({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      "${local.reading} ${local.the} ${local.quran}",
      style: gettitleTextStyle24(),
    );
  }
}
////"Reading the Quran",
