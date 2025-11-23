import 'package:flutter/material.dart';
import 'package:hantera/presentation/core/constant/routes_values.dart';
import 'package:hantera/presentation/core/extension/color_extension.dart';
import 'package:hantera/presentation/core/widget/no_transitions_builder.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:hantera/presentation/core/service/route_service.dart';
import 'package:hantera/presentation/core/service/theme_service.dart';
import 'package:hantera/injector.dart' as di;
import 'data/datasource/local/hive_data_source.dart';
import 'injector.dart';

void main() async {

  /// ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT HIVE LOCAL DATABASE
  await HiveDataSource.init();

  /// INIT DEPENDENCY INJECTION
  await di.init();

  final hasCompletedOnboarding = Hive.box('settingBox').get('onboardingCompleted', defaultValue: false) as bool;

  /// RUN APP
  runApp(MyApp(hasCompletedOnboarding: hasCompletedOnboarding));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.hasCompletedOnboarding});

  final bool hasCompletedOnboarding;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<ThemeService>(),
        )
      ],
      child: Consumer<ThemeService> (
        builder: (context, ThemeService themeService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hantera',
            // theme: themeService.currentThemeData(ThemeServiceValues.light),
            // darkTheme: themeService.currentThemeData(ThemeServiceValues.dark),
            theme: ThemeData(
              colorScheme: ColorScheme.light(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  surface: HexColor('f6f6f6'),
                  onSurface: Colors.black,
                  shadow: HexColor('e6e6e7')
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.black),
              ),
              hoverColor: HexColor('ffffff'),
              fontFamily: 'Poppins',
              useMaterial3: true,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: NoTransitionsBuilder(),
                TargetPlatform.iOS: NoTransitionsBuilder(),
                TargetPlatform.macOS: NoTransitionsBuilder(),
                TargetPlatform.windows: NoTransitionsBuilder(),
                TargetPlatform.linux: NoTransitionsBuilder(),
                TargetPlatform.fuchsia: NoTransitionsBuilder(),
              }),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.dark(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  surface: HexColor('0e0e0e'),
                  onSurface: Colors.white,
                  shadow: HexColor('272729')
              ),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white),
              ),
              hoverColor: HexColor('1a1a1a'),
              fontFamily: 'Poppins',
              useMaterial3: true,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: NoTransitionsBuilder(),
                TargetPlatform.iOS: NoTransitionsBuilder(),
                TargetPlatform.macOS: NoTransitionsBuilder(),
                TargetPlatform.windows: NoTransitionsBuilder(),
                TargetPlatform.linux: NoTransitionsBuilder(),
                TargetPlatform.fuchsia: NoTransitionsBuilder(),
              }),
            ),
            themeMode: themeService.currentThemeMode,
            initialRoute: hasCompletedOnboarding
                ? RoutesValues.home
                : RoutesValues.onboarding,
            onGenerateRoute: RouteService.generate,
            builder: (context, child) {
              final theme = Theme.of(context);
              final backgroundColor = theme.colorScheme.surface;
              final isDarkTheme = theme.brightness == Brightness.dark;
              final overlayStyle = (isDarkTheme
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark)
                  .copyWith(
                systemNavigationBarColor: backgroundColor,
                systemNavigationBarIconBrightness:
                isDarkTheme ? Brightness.light : Brightness.dark,
                systemNavigationBarDividerColor: Colors.transparent,
              );

              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: overlayStyle,
                child: ColoredBox(
                  color: backgroundColor,
                  child: SafeArea(
                    top: false,
                    bottom: true,
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
              );
            },
          );
        },
      )
    );

  }

}
