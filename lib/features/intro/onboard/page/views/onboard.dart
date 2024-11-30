// features/intro/onboard/page/views/onboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/functions/notification.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/intro/onboard/data/onboard_class.dart';
import 'package:islami/features/navigationBar/page/views/navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    currentIndex == 0
        ? NotificationService.showInstantNotification(
            "Islami", "Welcome To Islami App")
        : null;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.decorate_bgPng,
                width: mediaquery.height / 2.8,
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                const Gap(100),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: onboardContents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SvgPicture.asset(
                            onboardContents[index].title,
                            width: mediaquery.width / 2,
                          ),
                          const Spacer(),
                          Image.asset(
                            onboardContents[index].centerImage,
                            width: mediaquery.width,
                            height: mediaquery.height / 2,
                          ),
                          const Spacer(),
                          Container(
                            child: onboardContents[index].contentWidget,
                          ),
                          const Gap(26),
                          currentIndex == 0
                              ? Container(
                                  child: onboardContents[index].description,
                                )
                              : SizedBox(
                                  width: mediaquery.width / 1.5,
                                  child: onboardContents[index].descriptionText,
                                ),
                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ),

                //////////////////////////////////////////////////dots and button back next finish
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    currentIndex == 0
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              _controller.previousPage(
                                  duration: const Duration(milliseconds: 130),
                                  curve: Curves.easeIn);
                            },
                            child: Text(
                              locale.back,
                              style: gettitleTextStyle16(),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardContents.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (currentIndex == onboardContents.length - 1) {
                          pushWithReplacement(
                              context, const NavigationBarScreen());
                        }
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 130),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Text(
                        currentIndex == onboardContents.length - 1
                            ? locale.finish
                            : locale.next,
                        style: gettitleTextStyle16(),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 7,
      width: currentIndex == index ? 30 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? AppColors.primaryColor
            : AppColors.grayColor,
      ),
    );
  }
}
