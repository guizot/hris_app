import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hantera/core/theme/app_theme.dart';
import 'package:hantera/features/auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          FontAwesomeIcons.buildingUser,
                          size: 80,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome to Hantera',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: AppTheme.textColorPrimary,
                              fontSize: 36,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your HR Management System',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.textColorSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildMenuCard(
                          context,
                          'Employee Management',
                          FontAwesomeIcons.users,
                          () {
                            context.go('/employees');
                          },
                        ),
                        _buildMenuCard(
                          context,
                          'Attendance',
                          FontAwesomeIcons.clock,
                          () {
                            // TODO: Navigate to attendance page
                          },
                        ),
                        _buildMenuCard(
                          context,
                          'Leave Management',
                          FontAwesomeIcons.calendarDays,
                          () {
                            // TODO: Navigate to leave management page
                          },
                        ),
                        _buildMenuCard(
                          context,
                          'Organization',
                          FontAwesomeIcons.sitemap,
                          () {
                            // TODO: Navigate to organization page
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          context.go('/profile');
                        },
                        icon: Icon(
                          FontAwesomeIcons.user,
                          color: AppTheme.primaryColor,
                        ),
                        label: Text(
                          'Profile',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        icon: Icon(
                          FontAwesomeIcons.rightFromBracket,
                          color: AppTheme.errorColor,
                        ),
                        label: Text(
                          'Logout',
                          style: TextStyle(
                            color: AppTheme.errorColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textColorPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
