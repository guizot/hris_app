import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final notifications = [
      {
        'icon': Icons.check_circle,
        'color': theme.colorScheme.primary,
        'title': 'Leave Request Approved',
        'subtitle': 'Your leave from Dec 1-3 has been approved by HR Manager.',
        'time': '2 min ago',
        'isRead': false,
      },
      {
        'icon': Icons.assignment,
        'color': theme.colorScheme.secondary,
        'title': 'New Task Assigned',
        'subtitle': 'Performance review meeting scheduled for tomorrow.',
        'time': '1 hour ago',
        'isRead': true,
      },
      {
        'icon': Icons.schedule,
        'color': theme.colorScheme.tertiary,
        'title': 'Attendance Recorded',
        'subtitle': "Today's attendance has been successfully marked.",
        'time': 'Today, 9:00 AM',
        'isRead': true,
      },
      {
        'icon': Icons.account_balance_wallet,
        'color': theme.colorScheme.primary,
        'title': 'Payroll Processed',
        'subtitle': 'November payroll has been processed and deposited.',
        'time': 'Yesterday',
        'isRead': true,
      },
      {
        'icon': Icons.notifications,
        'color': theme.colorScheme.error,
        'title': 'Team Meeting Reminder',
        'subtitle': 'Weekly standup meeting in 30 minutes. Join via Zoom.',
        'time': '5 min ago',
        'isRead': false,
      },
      {
        'icon': Icons.star,
        'color': theme.colorScheme.tertiaryContainer,
        'title': 'Performance Bonus',
        'subtitle': 'You have been awarded a performance bonus for Q4.',
        'time': '2 days ago',
        'isRead': true,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        final isUnread = notification['isRead'] == false;
        
        return Card(
          elevation: isUnread ? 4 : 1,
          color: isUnread 
              ? theme.colorScheme.surfaceVariant.withOpacity(0.5)
              : theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isUnread 
                ? BorderSide(color: theme.colorScheme.primary.withOpacity(0.3), width: 2)
                : BorderSide.none,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: (notification['color'] as Color).withOpacity(0.1),
              child: Icon(
                notification['icon'] as IconData,
                color: notification['color'] as Color,
                size: 24,
              ),
            ),
            title: Text(
              notification['title'] as String,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                notification['subtitle'] as String,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  notification['time'] as String,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (isUnread)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            onTap: () {
              // TODO: Mark as read and navigate to details
            },
          ),
        );
      },
    );
  }
}
