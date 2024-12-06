// features/today_werd/page/widget/task_item.dart
import 'package:flutter/material.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/features/today_werd/data/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskmodel});

  final TaskMdel taskmodel;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: mediaquery.height * .01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: taskmodel.color == 3
            ? Colors.green
            : taskmodel.color == 0
                ? AppColors.primaryColor
                : taskmodel.color == 1
                    ? Colors.orange
                    : Colors.red,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskmodel.title ?? " ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: gettitleTextStyle14(
                    color: AppColors.whiteColor,
                    fontsize: mediaquery.width * .04,
                  ),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.whiteColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: mediaquery.width * .02,
                    ),
                    Text(
                      "${taskmodel.startTime} : ${taskmodel.endTime}",
                      style: gettitleTextStyle16(
                        color: AppColors.whiteColor,
                        fontsize: mediaquery.width * .035,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                Text(
                  taskmodel.note ?? "",
                  style: gettitleTextStyle16(
                      color: AppColors.whiteColor,
                      fontsize: mediaquery.width * .045,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: mediaquery.height * .1,
            color: AppColors.grayColor,
          ),
          SizedBox(
            width: mediaquery.width * .02,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              (taskmodel.isCompleted ?? false) ? "COMPLETE" : "TODO",
              style: gettitleTextStyle16(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
