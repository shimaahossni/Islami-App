// core/custom_widget/bg_cliprect.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class BgCliprect extends StatelessWidget {
  const BgCliprect({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingProvider>(context);
    return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: vm.isDark()
                    ? AppColors.blackColor.withOpacity(.3)
                    : AppColors.whiteColor.withOpacity(.1),
              ),
            ),
          );
  }
}