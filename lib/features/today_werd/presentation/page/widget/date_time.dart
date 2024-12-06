// features/today_werd/presentation/page/widget/date_time.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:islami/features/today_werd/presentation/page/views/add_new_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DateAndAddTaskButton extends StatefulWidget {
  const DateAndAddTaskButton({super.key});

  @override
  State<DateAndAddTaskButton> createState() => _DateAndAddTaskButtonState();
}

class _DateAndAddTaskButtonState extends State<DateAndAddTaskButton> {
  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);
    DateTime focusDate = DateTime.now();
    String date = DateFormat.yMMMMd().format(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: mediaquery.width * .06,
                  fontWeight: FontWeight.bold),
            ),
            Text(
                (DateFormat.E().format(focusDate)) ==
                        (DateFormat.E().format(focusDate))
                    ? local.today
                    : DateFormat.E().format(focusDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaquery.width * .06,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          width: mediaquery.width * .1,
        ),

        ///////////////////////////////////////////////button
        Column(
          children: [
            ///////////////////////////////////////upload image

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor:
                    vm.isDark() ? AppColors.primaryColor : AppColors.whiteColor,
                foregroundColor:
                    vm.isDark() ? AppColors.whiteColor : AppColors.blackColor,
              ),
              onPressed: () {
                pushTo(context, AddNewTask());
              },
              icon: const Icon(Icons.add),
              label: Text(
                "${local.add} ${local.werd}",
                style: TextStyle(
                    color: vm.isDark()
                        ? AppColors.whiteColor
                        : AppColors.blackColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  uploadImage({required bool isCamera}) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        AppLocalStorage.cachedData(AppLocalStorage.imageKey, value.path);
        setState(() {});
        Navigator.of(context).pop();
      }
    });
  }
}
