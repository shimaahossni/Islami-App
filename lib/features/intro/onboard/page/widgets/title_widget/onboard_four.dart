// features/intro/onboard/page/widgets/title_widget/onboard_four.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/core/functions/text_font.dart';

class OnboardFour extends StatelessWidget {
  const OnboardFour({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      local.bearish,
      style: gettitleTextStyle24(),
    );
  }
}
//"Bearish",
