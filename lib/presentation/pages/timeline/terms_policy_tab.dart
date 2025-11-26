import 'package:flutter/material.dart';

class TermsPolicyTab extends StatefulWidget {
  const TermsPolicyTab({super.key});

  @override
  State<TermsPolicyTab> createState() => _TermsPolicyTabState();
}

class _TermsPolicyTabState extends State<TermsPolicyTab> {
  final List<Map<String, String>> _termsPolicy = [
    {
      "title": "Privacy Policy",
      "description": "How we collect and use your personal data",
      "lastUpdated": "01 Nov 2025",
      "version": "2.1"
    },
    {
      "title": "Terms of Service",
      "description": "Agreement between you and the company",
      "lastUpdated": "15 Oct 2025",
      "version": "3.0"
    },
    {
      "title": "Code of Conduct",
      "description": "Expected behavior and workplace standards",
      "lastUpdated": "10 Nov 2025",
      "version": "1.5"
    },
    {
      "title": "Data Security Policy",
      "description": "Guidelines for handling sensitive information",
      "lastUpdated": "05 Nov 2025",
      "version": "2.0"
    },
    {
      "title": "Remote Work Policy",
      "description": "Guidelines and expectations for remote employees",
      "lastUpdated": "20 Oct 2025",
      "version": "1.2"
    },
    {
      "title": "Acceptable Use Policy",
      "description": "Rules for using company resources and equipment",
      "lastUpdated": "12 Nov 2025",
      "version": "2.3"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 120),
        itemCount: _termsPolicy.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final policy = _termsPolicy[index];
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
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.description,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  policy['title']!,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'v${policy['version']!}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            policy['description']!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.update,
                                size: 14,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Updated: ${policy['lastUpdated']!}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
