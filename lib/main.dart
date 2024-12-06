// main.dart
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'features/quran/data/model/recieve/ayah_of_the_day/aya_of_the-day.dart';
import 'features/quran/data/repo/quran_service.dart';

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
  //create box for ayah of the day
  await Hive.openBox('Ayah');
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
  AyaOfTheDay? data;
  @override
  Widget build(BuildContext context) {
    //var locale=AppLocalizations.of(context)!;



    //notification
    final myCoordinates2 = Coordinates(
        AdhanService().currentPostion?.latitude ?? 0,
        AdhanService().currentPostion?.longitude ?? 0);

    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates2, params);

    // Create a list of prayer times adjusted with the timezone offsets
    List<DateTime> prayerTimesList2 = [
      DateTime.now().add(prayerTimes.fajr.timeZoneOffset),
      DateTime.now().add(prayerTimes.dhuhr.timeZoneOffset),
      DateTime.now().add(prayerTimes.asr.timeZoneOffset),
      DateTime.now().add(prayerTimes.maghrib.timeZoneOffset),
      DateTime.now().add(prayerTimes.isha.timeZoneOffset),
    ];

// Retrieve cached notification data and convert it into a list of DateTime objects
    List<DateTime> cachedPrayerTimes = (AppLocalStorage.getCachedNotificationData(
        AppLocalStorage.notificationKey) as List<dynamic>?)
        ?.map((e) {
      try {
        print("cachedPrayerTimes: $e");
        return DateTime.parse(e.toString());
      } catch (error) {
        print('Error parsing cached date: $e'); // Error handling
        return null; // Return null for invalid entries
      }
    })
        .whereType<DateTime>() // Filter out null values
        .toList() ??
        [];

// Add new prayer times to cached data, ensuring no duplicates
    for (var time in prayerTimesList2) {
      if (!cachedPrayerTimes.contains(time)) {
        cachedPrayerTimes.add(time);
      }
    }

// Save the updated prayer times back to local storage
    AppLocalStorage.cachedNotificationData(
      AppLocalStorage.notificationKey,
      cachedPrayerTimes.map((e) => e.toIso8601String()).toList(),
    );

// Schedule notifications for each prayer time
    for (int i = 0; i < prayerTimesList2.length; i++) {
      try {
        NotificationService.schedulePrayerTimesNotificationList(
          i, // Unique ID for each notification
          "Salah Reminder", // Title
          "It's time for Salah!", // Message
          prayerTimesList2[i],
          // Notification time
        );
        print("Scheduled notification for: ${prayerTimesList2[i]}");
      } catch (error) {
        print("Error scheduling notification for ${prayerTimesList2[i]}: $error");
      }
    }


    // Schedule notification for today's Ayah of the Day

    NotificationService.repeated(
      1,
      //"${locale.sura_of_this_day_is} :",
      "Surah of this day is :",
      AppLocalStorage.getCachedAyahData(AppLocalStorage.AyahKey) ?? "",
    //  AppLocalStorage.getCachedAyahData(AppLocalStorage.AyahKey),
    );

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
