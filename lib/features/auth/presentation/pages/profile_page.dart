import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hantera/core/theme/app_theme.dart';
import 'package:hantera/features/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Unauthenticated) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/auth/sign-in');
                    });
                  }
                },
                builder: (context, state) {
                  if (state is! Authenticated) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                      ),
                    );
                  }

                  final user = state.user;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => context.go('/home'),
                            icon: const Icon(
                              FontAwesomeIcons.arrowLeft,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Profile',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Avatar + name section
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.user,
                                size: 32,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              user.name ?? 'User name',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.email ?? 'user@example.com',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textColorSecondary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Main card with info & actions
                      Expanded(
                        child: Column(
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Account',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      context,
                                      label: 'User ID',
                                      value: user.id?.toString() ?? 'N/A',
                                      icon: FontAwesomeIcons.idBadge,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      context,
                                      label: 'Email',
                                      value: user.email ?? 'N/A',
                                      icon: FontAwesomeIcons.envelope,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)).borderRadius,
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildActionTile(
                                    context,
                                    title: 'Edit profile',
                                    icon: FontAwesomeIcons.userPen,
                                    onTap: () {
                                      // TODO: navigate to edit profile
                                    },
                                  ),
                                  const Divider(height: 1),
                                  _buildActionTile(
                                    context,
                                    title: 'Change password',
                                    icon: FontAwesomeIcons.lock,
                                    onTap: () {
                                      // TODO: navigate to change password
                                    },
                                  ),
                                  const Divider(height: 1),
                                  _buildActionTile(
                                    context,
                                    title: 'Settings',
                                    icon: FontAwesomeIcons.gear,
                                    onTap: () {
                                      // TODO: navigate to settings
                                    },
                                  ),
                                  const Divider(height: 1),
                                  _buildActionTile(
                                    context,
                                    title: 'Help & support',
                                    icon: FontAwesomeIcons.circleQuestion,
                                    onTap: () {
                                      // TODO: navigate to help & support
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            // Logout button aligned with auth buttons
                            SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () => _showLogoutDialog(context),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.errorColor,
                                  side: BorderSide(color: AppTheme.errorColor.withOpacity(0.2)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(
                                  FontAwesomeIcons.rightFromBracket,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 14,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textColorMuted,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 18,
        color: AppTheme.textColorSecondary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppTheme.textColorMuted,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}