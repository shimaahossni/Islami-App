// features/intro/onboard/page/widgets/onborad_two.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/core/functions/text_font.dart';


class OnboradTwo extends StatelessWidget {
  const OnboradTwo({super.key});

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    return Text("${local.welcome} ${local.to} ${local.islami}", style: gettitleTextStyle24(),);
  }
}
//Welcome To Islami