// features/intro/onboard/page/widgets/onboard_five.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/core/functions/text_font.dart';

class OnboardFive extends StatelessWidget {
  const OnboardFive({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      "${local.holly} ${local.quran}",
      style: gettitleTextStyle24(),
    );
  }
}
//Holy Quran
