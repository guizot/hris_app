import 'package:flutter/material.dart';
import '../../../data/core/const/shared_preferences_values.dart';
import '../../../data/datasource/shared/shared_preferences_data_source.dart';
import '../constant/theme_service_values.dart';
import '../widget/no_transitions_builder.dart';
import '../extension/color_extension.dart';

class ThemeService extends ChangeNotifier {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  ThemeService({required this.sharedPreferenceDataSource}) {
    _themeMode = ThemeServiceValues.system;
    _colorSeed = ThemeServiceValues.colorBlue;
    getPreferences();
  }

  late String _themeMode;
  String get themeMode => _themeMode;

  set themeMode(String value) {
    _themeMode = value;
    sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, value);
    notifyListeners();
  }

  late String _colorSeed;
  String get colorSeed => _colorSeed;

  set colorSeed(String value) {
    _colorSeed = value;
    sharedPreferenceDataSource.setString(SharedPreferencesValues.currentColor, value);
    notifyListeners();
  }

  getPreferences() async {
    _themeMode = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentTheme);
    if(_themeMode == "") {
      themeMode = ThemeServiceValues.system;
    }
    _colorSeed = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentColor);
    if(_colorSeed == "") {
      colorSeed = ThemeServiceValues.colorBlue;
    }
    notifyListeners();
  }

  ThemeMode get currentThemeMode {
    switch(themeMode) {
      case ThemeServiceValues.light:
        return ThemeMode.light;
      case ThemeServiceValues.dark:
        return ThemeMode.dark;
      case ThemeServiceValues.system:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData currentThemeData(String brightness) {
    return getThemeData(brightness, colorSeed);
  }

  ThemeData getThemeData(String brightness, String color) {

    Brightness brightnessTheme;
    switch(brightness) {
      case ThemeServiceValues.light:
        brightnessTheme = Brightness.light;
      case ThemeServiceValues.dark:
        brightnessTheme = Brightness.dark;
      default:
        brightnessTheme = Brightness.light;
    }

    Color colorTheme;
    Map<String, Color> colorObject = {};
    for (int i = 0; i < ThemeServiceValues.colorString.length; i++) {
      colorObject[ThemeServiceValues.colorString[i]] = ThemeServiceValues.colorValue[i];
    }
    colorTheme = colorObject[color] ?? HexColor(color);

    return ThemeData(
      colorSchemeSeed: colorTheme,
      fontFamily: 'Poppins',
      brightness: brightnessTheme,
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: NoTransitionsBuilder(),
        TargetPlatform.iOS: NoTransitionsBuilder(),
        TargetPlatform.macOS: NoTransitionsBuilder(),
        TargetPlatform.windows: NoTransitionsBuilder(),
        TargetPlatform.linux: NoTransitionsBuilder(),
        TargetPlatform.fuchsia: NoTransitionsBuilder(),
      }),
    );
  }

}
