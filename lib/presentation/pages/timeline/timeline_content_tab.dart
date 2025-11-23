import 'package:flutter/material.dart';

class TimelineContentTab extends StatelessWidget {
  const TimelineContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Timeline Content',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
