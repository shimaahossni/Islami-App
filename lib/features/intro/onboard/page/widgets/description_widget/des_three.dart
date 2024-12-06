// features/intro/onboard/page/widgets/description_widget/des_three.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesThree extends StatelessWidget {
  const DesThree({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      local.praise_the_name_of_your_lord_the_most_high,
      style: gettitleTextStyle20(),
      textAlign: TextAlign.center,
    );
  }
}
// "Praise the name of your Lord, the\n Most High",
