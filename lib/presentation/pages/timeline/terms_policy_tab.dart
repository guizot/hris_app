import 'package:flutter/material.dart';

class TermsPolicyTab extends StatelessWidget {
  const TermsPolicyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Terms & Policy',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
