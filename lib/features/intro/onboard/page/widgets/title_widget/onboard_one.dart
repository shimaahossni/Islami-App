// features/intro/onboard/page/widgets/onboard_one.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/core/functions/text_font.dart';

class OnboardOne extends StatelessWidget {
  const OnboardOne({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Text(
      "${locale.choose} ${locale.language}",
      style: gettitleTextStyle24(),
    );
  }
}
