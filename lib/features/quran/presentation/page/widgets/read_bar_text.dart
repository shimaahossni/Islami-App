// features/quran/page/widgets/read_bar_text.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReadBarText extends StatelessWidget {
  const ReadBarText({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingProvider>(context);
    var locale = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(
          locale.recently_read,
          style: gettitleTextStyle20(
              color:
                  vm.isDark() ? AppColors.primaryColor : AppColors.whiteColor),
        ),
      ],
    );
  }
}
