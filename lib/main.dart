import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hantera/core/theme/app_theme.dart';
import 'package:hantera/core/router/app_router.dart';
import 'package:hantera/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hantera/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authBloc = di.sl<AuthBloc>();
        // Check for existing session on app start
        authBloc.add(CheckAuthEvent());
        return authBloc;
      },
      child: MaterialApp.router(
        title: 'HRIS App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
