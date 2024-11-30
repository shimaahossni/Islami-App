// main.dart
import 'dart:developer';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islami/core/functions/adhan.dart';
import 'package:islami/core/functions/notification.dart';
import 'package:islami/core/services/app_local_storage.dart';
import 'package:islami/core/services/dio_provider.dart';
import 'package:islami/features/hadeth/presentation/bloc/hadith_time_bloc.dart';
import 'package:islami/features/intro/splash/page/views/splash_screen.dart';
import 'package:islami/features/prayerTime/presentation/bloc/azkar_bloc.dart';
import 'package:islami/features/setting/data/setting_provider.dart';
import 'package:islami/features/today_werd/data/task_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive db
  await Hive.initFlutter();
  //create or open a box(table name)...
  await Hive.openBox('user');
  //type adapter generator
  Hive.registerAdapter(TaskMdelAdapter());
  //create box for task table
  await Hive.openBox<TaskMdel>("task");
  //////////////////////create box for sebha
  await Hive.openBox('sebha');
  //create box for notification
  await Hive.openBox('notification');
  //initialize app
  await AppLocalStorage.init();

  ////////notification and timezone
  await NotificationService.init();
  tz.initializeTimeZones();

  ///////dio prrovider
  await DioProvider.init();
  runApp((ChangeNotifierProvider(
      create: (BuildContext context) => SettingProvider(), child: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //notification
    final myCoordinates2 = Coordinates(
        AdhanService().currentPostion?.latitude ?? 0,
        AdhanService().currentPostion?.longitude ?? 0);

    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates2, params);
    // print(prayerTimes.asr);
    // final x = DateTime.now().add(Duration(days: 1));
    // print(x);

    List<DateTime> prayerTimesList2 = [
      DateTime.now().add(prayerTimes.fajr.timeZoneOffset),
      DateTime.now().add(prayerTimes.dhuhr.timeZoneOffset),
      DateTime.now().add(prayerTimes.asr.timeZoneOffset),
      DateTime.now().add(prayerTimes.maghrib.timeZoneOffset),
      DateTime.now().add(prayerTimes.isha.timeZoneOffset),
    ];
    print(prayerTimesList2.runtimeType);
    //cach notifications for notificationbox
    for (int i = 0; i < prayerTimesList2.length; i++) {
      AppLocalStorage.cachedNotificationData(
          AppLocalStorage.notificationKey, [prayerTimesList2[i]]);
    }

    NotificationService.scheduleNotificationList(
        0,
        "salah",
        "Its time for salah",
        AppLocalStorage.getCachedNotificationData(
            AppLocalStorage.notificationKey));
    print(AppLocalStorage.getCachedNotificationData(
        AppLocalStorage.notificationKey));

    var vm = Provider.of<SettingProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HadithTimeBloc(),
        ),
        BlocProvider(create: (context) => AzkarBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Islami zaker App',
        themeMode: vm.currentTheme,
        locale: Locale(vm.currentLanguage),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SplashScreen(),
      ),
    );
  }
}
//
