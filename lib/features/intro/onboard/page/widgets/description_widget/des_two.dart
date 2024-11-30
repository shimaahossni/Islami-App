// features/intro/onboard/page/widgets/description_widget/des_two.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesTwo extends StatelessWidget {
  const DesTwo({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      local.read_and_your_lord_is_the_most_generous,
      style: gettitleTextStyle20(),
      textAlign: TextAlign.center,
    );
  }
}
//"Read, and your Lord is the Most Generous",
