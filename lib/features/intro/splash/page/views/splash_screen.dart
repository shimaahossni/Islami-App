// features/intro/splash/page/views/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:islami/core/functions/navigation.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/utils/app_images.dart';
import 'package:islami/features/intro/onboard/page/views/onboard.dart';
import 'package:islami/features/navigationBar/presentation/page/views/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      pushWithReplacement(
        context,
        (AppLocalStorage.getCachedData(AppLocalStorage.nameKey) == null &&
                AppLocalStorage.getCachedSebhaData(AppLocalStorage.sebhaKey) ==
                    null &&
                AppLocalStorage.taskBox.isEmpty)
            ? OnBoardScreen()
            : const NavigationBarScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.Splash_Screen_bgPng,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.logo_imageSvg),
                const Gap(20),
                SvgPicture.asset(AppImages.Islami_logo_textSvg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
