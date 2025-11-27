import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Mock data for current user - replace with Hive/repo data
    const userData = {
      'imageUrl': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80',
      'name': 'John Doe',
      'email': 'john.doe@company.com',
      'jobTitle': 'Senior Software Engineer',
      'employeeId': 'EMP-00123',
      'company': 'Acme Corporation',
    };

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Profile Header Card
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Avatar
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(userData['imageUrl']!),
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.person, size: 55, color: Colors.white60),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, size: 20, color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Name & Job Title
                Text(
                  userData['name']!,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  userData['jobTitle']!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                // Company & Employee ID
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.business, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('Employee ID: ${userData['employeeId']}'),
                      const SizedBox(width: 8),
                      Icon(Icons.apartment, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(userData['company']!, style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Email
                ListTile(
                  leading: Icon(Icons.email_outlined, color: theme.colorScheme.primary),
                  title: const Text('Email'),
                  subtitle: Text(userData['email']!),
                  dense: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Settings Card
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.settings_outlined, color: theme.colorScheme.primary),
                title: const Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Settings')),
                ),
              ),
              const Divider(height: 1, indent: 72),
              ListTile(
                leading: Icon(Icons.security_outlined, color: theme.colorScheme.primary),
                title: const Text('Privacy'),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Privacy')),
                ),
              ),
              const Divider(height: 1, indent: 72),
              ListTile(
                leading: Icon(Icons.help_outline, color: theme.colorScheme.primary),
                title: const Text('Help & Support'),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Help')),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Logout Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.errorContainer,
              foregroundColor: theme.colorScheme.onErrorContainer,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logout pressed - implement auth clear')),
            ),
          ),
        ),
      ],
    );
  }
}
