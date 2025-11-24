import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Map<String, String> _selectedCompany = {
      "name": "Soylent Corp",
      "logo": "https://ui-avatars.com/api/?name=Soylent+Corp&background=random"
    };
  
  final List<Map<String, String>> _companies = [
    {
      "name": "Globex Corporation",
      "logo": "https://ui-avatars.com/api/?name=Globex+Corporation&background=random"
    },
    {
      "name": "Soylent Corp",
      "logo": "https://ui-avatars.com/api/?name=Soylent+Corp&background=random"
    },
    {
      "name": "Umbrella Corp",
      "logo": "https://ui-avatars.com/api/?name=Umbrella+Corp&background=random"
    },
    {
      "name": "Stark Industries",
      "logo": "https://ui-avatars.com/api/?name=Stark+Industries&background=random"
    }
  ];

  final List<Map<String, String>> _features = [
    {'name': 'Attendance', 'icon': 'assets/svg_feature/attendance_icon.svg'},
    {'name': 'Correction', 'icon': 'assets/svg_feature/correction_icon.svg'},
    {'name': 'Leave', 'icon': 'assets/svg_feature/leave_icon.svg'},
    {'name': 'Overtime', 'icon': 'assets/svg_feature/overtime_icon.svg'},
    {'name': 'Claim', 'icon': 'assets/svg_feature/claim_icon.svg'},
    {'name': 'Business Trip', 'icon': 'assets/svg_feature/business_trip_icon.svg'},
    {'name': 'Organization', 'icon': 'assets/svg_feature/organization_icon.svg'},
    {'name': 'Employees', 'icon': 'assets/svg_feature/employees_icon.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUserInfo(context),
            const SizedBox(height: 12),
            _buildCompanySelector(context),
            const SizedBox(height: 12),
            _buildAttendanceInfo(context),
            const SizedBox(height: 16),
            _buildFeatureGrid(context)
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceInfo(BuildContext context) {
    return Material(
      color: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48),
        side: BorderSide(
          color: Theme.of(context).colorScheme.shadow,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(48),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAttendanceItem(context, "Date", "24 Nov 2025", Icons.calendar_today),
              Container(width: 1, height: 40, color: Theme.of(context).colorScheme.shadow),
              _buildAttendanceItem(context, "Clock In", "08:00", Icons.login),
              Container(width: 1, height: 40, color: Theme.of(context).colorScheme.shadow),
              _buildAttendanceItem(context, "Clock Out", "--:--", Icons.logout),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 12),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Material(
      color: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48),
        side: BorderSide(
          color: Theme.of(context).colorScheme.shadow,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(48),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@example.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanySelector(BuildContext context) {
    return Material(
      color: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: Theme.of(context).colorScheme.shadow,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _showCompanyBottomSheet(context),
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(_selectedCompany['logo']!),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _selectedCompany['name']!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCompanyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _companies.length,
                  itemBuilder: (context, index) {
                    final company = _companies[index];
                    final isSelected = company['name'] == _selectedCompany['name'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCompany = company;
                          });
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(32),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).hoverColor,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: isSelected 
                                ? Theme.of(context).colorScheme.primary 
                                : Theme.of(context).colorScheme.shadow,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(company['logo']!),
                                backgroundColor: Colors.transparent,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  company['name']!,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Theme.of(context).colorScheme.primary : null,
                                      ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _features.length,
      itemBuilder: (context, index) {
        final feature = _features[index];
        return Material(
          color: Theme.of(context).hoverColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.shadow,
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    feature['icon']!,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                    width: 38,
                    height: 38,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    feature['name']!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
