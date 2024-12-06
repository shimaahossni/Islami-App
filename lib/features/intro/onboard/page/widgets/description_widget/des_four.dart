// features/intro/onboard/page/widgets/description_widget/des_four.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesFour extends StatelessWidget {
  const DesFour({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Text(
      local
          .you_can_listen_to_the_holy_quran_radio_through_the_application_for_free_and_easily,
      style: gettitleTextStyle20(),
      textAlign: TextAlign.center,
    );
  }
}
//      "You can listen to the Holy Quran\n Radio through the application for\n free and easily",
