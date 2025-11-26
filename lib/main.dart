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
import 'presentation/core/constant/theme_service_values.dart';
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
            theme: themeService.currentThemeData(ThemeServiceValues.light),
            darkTheme: themeService.currentThemeData(ThemeServiceValues.dark),
            themeMode: themeService.currentThemeMode,
            initialRoute: hasCompletedOnboarding
                ? RoutesValues.login
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
