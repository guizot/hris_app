import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> features = [
      {'icon': 'assets/svg_feature/announcement_icon.svg', 'label': 'Announcement'},
      {'icon': 'assets/svg_feature/attendance_icon.svg', 'label': 'Attendance'},
      {'icon': 'assets/svg_feature/business_trip_icon.svg', 'label': 'Business Trip'},
      {'icon': 'assets/svg_feature/claim_icon.svg', 'label': 'Claim'},
      {'icon': 'assets/svg_feature/correction_icon.svg', 'label': 'Correction'},
      {'icon': 'assets/svg_feature/dashboard_icon.svg', 'label': 'Dashboard'},
      {'icon': 'assets/svg_feature/employees_icon.svg', 'label': 'Employees'},
      {'icon': 'assets/svg_feature/leave_icon.svg', 'label': 'Leave'},
      {'icon': 'assets/svg_feature/organization_icon.svg', 'label': 'Organization'},
      {'icon': 'assets/svg_feature/overtime_icon.svg', 'label': 'Overtime'},
      {'icon': 'assets/svg_feature/subscription_icon.svg', 'label': 'Subscription'},
      {'icon': 'assets/svg_feature/terms_policy_icon.svg', 'label': 'Terms Policy'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: features.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(features[index]['icon']!),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              features[index]['label']!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
