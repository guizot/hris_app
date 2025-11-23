import 'package:hive_flutter/hive_flutter.dart';



class HiveDataSource {

  /// Init Hive Local Storage
  static Future<void> init() async {
    await Hive.initFlutter();

    /// Define the adapters




    /// Open the boxes

    await Hive.openBox('settingBox');
  }

  /// Get the boxes

  Box get settingBox => Hive.box('settingBox');

}