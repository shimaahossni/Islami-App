// features/intro/onboard/page/widgets/description_widget/des_one.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesOne extends StatelessWidget {
  const DesOne({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      local.we_are_very_excited_to_have_you_in_our_community,
      style: gettitleTextStyle20(),
      textAlign: TextAlign.center,
    );
  }
}
// "We Are Very Excited To Have You In\n Our Community",
