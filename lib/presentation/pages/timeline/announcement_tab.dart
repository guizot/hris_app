import 'package:flutter/material.dart';

class AnnouncementTab extends StatefulWidget {
  const AnnouncementTab({super.key});

  @override
  State<AnnouncementTab> createState() => _AnnouncementTabState();
}

class _AnnouncementTabState extends State<AnnouncementTab> {
  final List<Map<String, String>> _announcements = [
    {
      "title": "Holiday Schedule",
      "description": "Office will be closed on Dec 25-26",
      "date": "20 Nov 2025",
      "priority": "high"
    },
    {
      "title": "New Parking Policy",
      "description": "Updated parking guidelines effective next month",
      "date": "18 Nov 2025",
      "priority": "medium"
    },
    {
      "title": "Team Building Event",
      "description": "Join us for team building activities this Friday",
      "date": "15 Nov 2025",
      "priority": "low"
    },
    {
      "title": "System Maintenance",
      "description": "Scheduled maintenance on Saturday 2-4 AM",
      "date": "22 Nov 2025",
      "priority": "high"
    },
    {
      "title": "New Benefits Program",
      "description": "Enhanced health and wellness benefits starting next quarter",
      "date": "10 Nov 2025",
      "priority": "medium"
    },
    {
      "title": "Office Renovation",
      "description": "Floor 3 will undergo renovation next month",
      "date": "08 Nov 2025",
      "priority": "low"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 120),
        itemCount: _announcements.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final announcement = _announcements[index];
          final priorityColor = announcement['priority'] == 'high'
              ? Colors.red
              : announcement['priority'] == 'medium'
                  ? Colors.orange
                  : Colors.blue;
          
          return Material(
            color: Theme.of(context).hoverColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: priorityColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            announcement['title']!,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: priorityColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            announcement['priority']!.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: priorityColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      announcement['description']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          announcement['date']!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
