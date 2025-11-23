import 'package:flutter/material.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notification Tab',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
