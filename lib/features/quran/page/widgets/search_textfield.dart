// features/quran/page/widgets/search_textfield.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_icons.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class SearchTextfield extends StatelessWidget {
  SearchTextfield({
    super.key,
    required this.hinttext,
    required this.searchController,
    this.onChanged,
  });
  String hinttext;
  TextEditingController? searchController;
  ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingProvider>(context);
    return TextField(
      style: gettitleTextStyle16(
          color: vm.isDark() ? AppColors.whiteColor : AppColors.primaryColor),
      controller: searchController,
      onChanged: (value) => onChanged!(value),
      decoration: InputDecoration(
        prefixIconConstraints:
            BoxConstraints(maxHeight: mediaquery.height * .05),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(
            AppIcons.vectorSvg,
            // ignore: deprecated_member_use
            color: AppColors.primaryColor,
          ),
        ),

        //hintText: locale.currentlocation,
        hintText: hinttext,
        hintStyle: gettitleTextStyle16(
          color: AppColors.whiteColor,
        ),
        filled: true,
        fillColor: Colors.transparent,
        // fillColor: vm.isDark()?Color(0xFF060E1E):Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }
}
