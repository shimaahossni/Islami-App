// core/services/app_local_storage.dart
import 'package:hive/hive.dart';
import 'package:islami/features/today_werd/data/task_model.dart';

class AppLocalStorage {
  static late Box userBox;
  static late Box<TaskMdel> taskBox;
  static late Box sebhaBox;
  static late Box notificationBox;

  static String nameKey = "nameKey";
  static String suraArabicKey = "suraArabicKey";
  static String suranNumber = "suraNumberKey";
  static String imageKey = "imageKey";
  static String sebhaKey = "sebhakey";
  static String isUpload = "isUploadKey";
  static String notificationKey = "notificationKey";


  static init() {
    userBox = Hive.box('user');
    taskBox = Hive.box<TaskMdel>('task');
    sebhaBox = Hive.box('sebha');
    notificationBox = Hive.box('notification');
  }

//////////////////////////////////////////////////////////////////////user box functions
  static cachedData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getCachedData(String key) {
    return userBox.get(key);
  }

  //////////////////////////////////////////////////////////////////////task box functions
  static cachedTaskData(String key, TaskMdel value) {
    taskBox.put(key, value);
  }

  static TaskMdel? getCachedTaskData(String key) {
    return taskBox.get(key);
  }

  //////////////////////////////////////////////////////////////////seha box functions
  static cachedSebhaData(String key, dynamic value) {
    sebhaBox.put(key, value);
  }

  static getCachedSebhaData(String key) {
    return sebhaBox.get(key);
  }

  //////////////////////////////////////////////////////////////////////notification box functions
  static cachedNotificationData(String key, dynamic value) {
    notificationBox.put(key, value);
  }

  static getCachedNotificationData(String key) {
    return notificationBox.get(key);
  }

}


