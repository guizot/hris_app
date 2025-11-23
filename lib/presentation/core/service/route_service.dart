import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../pages/home.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/auth/register_page.dart';
import '../../pages/onboarding/onboarding_page.dart';
import '../../pages/setting/setting.dart';
import '../constant/routes_values.dart';
import '../widget/image_view.dart';

class RouteService {

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesValues.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case RoutesValues.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesValues.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutesValues.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case RoutesValues.viewImage:
        var imageBytes = settings.arguments as Uint8List?;
        return MaterialPageRoute(builder: (_) => ImageView(imageBytes: imageBytes));
      case RoutesValues.setting:
        return MaterialPageRoute(builder: (_) => const SettingPage());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text('Error page')),
          );
        });
    }
  }

}