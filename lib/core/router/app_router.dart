import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hantera/features/auth/presentation/pages/sign_in_page.dart';
import 'package:hantera/features/auth/presentation/pages/sign_up_page.dart';
import 'package:hantera/features/auth/presentation/pages/home_page.dart';
import 'package:hantera/features/auth/presentation/pages/profile_page.dart';
import 'package:hantera/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hantera/features/employee/presentation/pages/employee_list_page.dart';
import 'package:hantera/features/employee/presentation/pages/employee_detail_page.dart';
import 'package:hantera/features/employee/presentation/pages/add_employee_page.dart';
import 'package:hantera/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:hantera/features/employee/domain/entities/employee.dart';
import 'package:hantera/service_locator.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/auth/sign-in',
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>();
      final authState = authBloc.state;
      
      // If user is not authenticated and trying to access protected routes, redirect to sign-in
      if (authState is! Authenticated &&
          !state.uri.path.startsWith('/auth/')) {
        return '/auth/sign-in';
      }
      
      // If user is authenticated and trying to access auth routes, redirect to home
      if (authState is Authenticated &&
          state.uri.path.startsWith('/auth/')) {
        return '/home';
      }
      
      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/auth/sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/auth/sign-up',
        builder: (context, state) => const SignUpPage(),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      
      // Employee Management Routes
      GoRoute(
        path: '/employees',
        builder: (context, state) => BlocProvider(
          create: (context) => sl<EmployeeBloc>(),
          child: const EmployeeListPage(),
        ),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => BlocProvider(
              create: (context) => sl<EmployeeBloc>(),
              child: const AddEmployeePage(),
            ),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final employeeId = state.pathParameters['id']!;
              return BlocProvider(
                create: (context) => sl<EmployeeBloc>(),
                child: EmployeeDetailPage(
                  employeeId: employeeId,
                  employee: state.extra as Employee?,
                ),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The requested page could not be found.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}