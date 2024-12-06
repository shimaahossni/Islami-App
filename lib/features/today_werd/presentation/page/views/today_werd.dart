// features/today_werd/presentation/page/views/today_werd.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/custom_widget/bg_cliprect.dart';
import 'package:islami/core/custom_widget/bg_image.dart';
import 'package:islami/core/custom_widget/bg_positioned.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:islami/features/today_werd/data/task_model.dart';
import 'package:islami/features/today_werd/presentation/page/views/add_new_task.dart';
import 'package:islami/features/today_werd/presentation/page/widget/date_time.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:islami/features/today_werd/presentation/page/widget/task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class TodayWerd extends StatefulWidget {
  const TodayWerd({super.key});

  @override
  State<TodayWerd> createState() => _TodayWerdState();
}

class _TodayWerdState extends State<TodayWerd> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ///////////////////////////////////////////////////bg image
          BgImage(
            image: AppImages.quran_voice_bgPng,
          ),
          const BgCliprect(),
          const BgPositioned(),
          /////////////////////////////////////////////////////////////body
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ////////////////////////////////////////////////////add new werd
                  const Gap(80),

                  const DateAndAddTaskButton(),

                  ////////////////////////////////////////////////////slider
                  const Gap(40),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(.1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(1, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: DatePicker(
                      width: mediaquery.width * .185,
                      height: mediaquery.height * .13,
                      DateTime.now().subtract(const Duration(days: 2)),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: vm.isDark()
                          ? AppColors.primaryColor
                          : AppColors.grayColor,
                      selectedTextColor: AppColors.whiteColor,
                      onDateChange: (date) {
                        setState(() {
                          selectedDate = DateFormat('dd/MM/yyyy').format(date);
                        });
                      },
                    ),
                  ),

                  ////////////////////////////////////////////////////////////////////listView tasks
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaquery.width * .02),
                    child: SizedBox(
                      height: mediaquery.height * .65,
                      child: ValueListenableBuilder(
                        valueListenable: AppLocalStorage.taskBox.listenable(),
                        builder: (context, box, child) {
                          List<TaskMdel> tasks = [];

                          for (var element in box.values) {
                            if (element.date == selectedDate) {
                              tasks.add(element);
                            }
                          }

                          if (tasks.isEmpty) {
                            return Column(
                              children: [
                                const Gap(100),
                                SvgPicture.asset(AppImages.Islami_logo_textSvg),
                                const Gap(30),
                                Text(
                                  "${local.no_werd_for}  $selectedDate",
                                  style: gettitleTextStyle24(
                                      color: vm.isDark()
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    //complete task
                                    box.put(
                                        tasks[index].id,
                                        TaskMdel(
                                            title: tasks[index].title,
                                            note: tasks[index].note,
                                            date: tasks[index].date,
                                            startTime: tasks[index].startTime,
                                            endTime: tasks[index].endTime,
                                            color: 3,
                                            id: tasks[index].id,
                                            isCompleted: true));
                                  } else {
                                    //delete task
                                    box.delete(tasks[index].id);
                                  }
                                },
                                secondaryBackground: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        color: AppColors.whiteColor,
                                      ),
                                      Text("Delete  ",
                                          style: gettitleTextStyle14(
                                              color: AppColors.whiteColor))
                                    ],
                                  ),
                                ),
                                background: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        color: AppColors.whiteColor,
                                      ),
                                      Text("Complete",
                                          style: gettitleTextStyle14(
                                              color: AppColors.whiteColor))
                                    ],
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    pushTo(context,
                                        AddNewTask(taskmodel: tasks[index]));
                                  },
                                  child: TaskItem(
                                    taskmodel: tasks[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
