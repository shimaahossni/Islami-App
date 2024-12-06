// features/hadeth/presentation/page/views/hadeth_screen.dart
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/custom_widget/bg_cliprect.dart';
import 'package:islami/core/custom_widget/bg_image.dart';
import 'package:islami/core/custom_widget/bg_positioned.dart';
import 'package:islami/core/functions/text_font.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/hadeth/presentation/page/widget/slider_bg_image.dart';
import 'package:islami/features/hadeth/presentation/page/widget/slider_bg_pos_one.dart';
import 'package:islami/features/hadeth/presentation/page/widget/slider_bg_pos_three.dart';
import 'package:islami/features/hadeth/presentation/page/widget/slider_bg_pos_two.dart';
import 'package:islami/features/hadeth/presentation/bloc/hadith_time_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:provider/provider.dart';

class HadethScreen extends StatefulWidget {
  HadethScreen({super.key});

  //late final HadithDetails hadithDetails;

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HadithTimeBloc>().add(GetHadithTimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingProvider>(context);

    return Scaffold(
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          ///////////////////////////////////////////////////bg image
          BgImage(
            image: AppImages.hadethBgPng,
          ),
          const BgCliprect(),
          const BgPositioned(),

          ///////////////////////////////////////////////////body
          BlocBuilder<HadithTimeBloc, HadithTimeState>(
            builder: (context, state) {
              if (state is HadithTimeSuccess) {
                var hadith = context.read<HadithTimeBloc>().hadithDetails;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(mediaquery.height * .12),
                    SvgPicture.asset(AppImages.Islami_logo_textSvg),

                    //////////////////////////////////////////slider listView for hadeth details

                    Gap(mediaquery.height * .05),
                    CarouselSlider.builder(
                      itemCount: hadith?.length,
                      options: CarouselOptions(
                        height: mediaquery.height / 1.5,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.25,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          width: mediaquery.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: vm.isDark()
                                ? AppColors.primaryColor.withOpacity(.9)
                                : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ///////////////////////////////////////////////////slider bg image
                              const SliderBgImage(),
                              const SliderBgPosOne(),
                              const SliderBgPosTwo(),
                              const SliderBgPosThree(),

                              ////////////////////////////////////////hadeth list
                              SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    Gap(mediaquery.height * .04),
                                    Text(
                                      '${local.hadith} ${hadith?[index].number.toString() ?? ""}',
                                      style: gettitleTextStyle24(
                                          color: AppColors.blackColor),
                                    ),
                                    Gap(20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: mediaquery.height / 2,
                                        child: Text(
                                          hadith?[index].arab ?? "",
                                          style: gettitleTextStyle18(
                                              color: AppColors.blackColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Gap(mediaquery.height * .02),
                  ],
                );

                ///////////////////////////////////////////state error
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ));
              }
            },
          ),
        ],
      )),
    );
  }
}
