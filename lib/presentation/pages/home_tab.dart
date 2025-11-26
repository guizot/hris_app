import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:hantera/presentation/core/service/theme_service.dart'; // adjust path if needed

class HomeTab extends StatefulWidget {
  final Function(int)? onNavigateToTimeline;
  
  const HomeTab({super.key, this.onNavigateToTimeline});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Map<String, String> _selectedCompany = {
      "name": "Soylent Corp",
      "logo": "https://ui-avatars.com/api/?name=Soylent+Corp&background=random"
    };
  
  Color? _companyBgColor;

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

  final List<Map<String, String>> _attendanceHistory = [
    {
      "date": "23 November 2025",
      "clockIn": "08:00",
      "clockOut": "17:00",
    },
    {
      "date": "22 November 2025",
      "clockIn": "08:15",
      "clockOut": "17:10",
    }
  ];

  final List<Map<String, String>> _newEmployees = [
    {
      "name": "Alice Smith",
      "role": "UI Designer",
      "photo": "https://ui-avatars.com/api/?name=Alice+Smith&background=random"
    },
    {
      "name": "Bob Jones",
      "role": "Developer",
      "photo": "https://ui-avatars.com/api/?name=Bob+Jones&background=random"
    },
    {
      "name": "Charlie Day",
      "role": "Product Owner",
      "photo": "https://ui-avatars.com/api/?name=Charlie+Day&background=random"
    },
    {
      "name": "Diana Prince",
      "role": "Manager",
      "photo": "https://ui-avatars.com/api/?name=Diana+Prince&background=random"
    },
  ];

  final List<Map<String, String>> _timeline = [
    {
      "title": "Project Kickoff",
      "date": "25 Nov 2025",
      "time": "09:00 AM",
      "type": "meeting"
    },
    {
      "title": "Code Review",
      "date": "25 Nov 2025",
      "time": "02:00 PM",
      "type": "review"
    },
    {
      "title": "Sprint Planning",
      "date": "26 Nov 2025",
      "time": "10:00 AM",
      "type": "meeting"
    },
    {
      "title": "Team Standup",
      "date": "26 Nov 2025",
      "time": "09:30 AM",
      "type": "meeting"
    },
  ];

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
  ];

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
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCompanyColor());
  }

  Future<void> _loadCompanyColor() async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(_selectedCompany['logo']!),
      );
      if (mounted && palette.dominantColor != null) {
        final companyColor = palette.dominantColor!.color;
        setState(() {
          _companyBgColor = companyColor;
        });
        // Update app-wide theme accent
        final themeService = Provider.of<ThemeService>(context, listen: false);
        final hex = '#${companyColor.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
        themeService.colorSeed = hex;
      }
    } catch (e) {
      // Fallback silently
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          // Scrolling content behind
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                // _buildUserInfo(context),
                // const SizedBox(height: 16),
                _buildAttendanceInfo(context),
                const SizedBox(height: 30),
                _buildSectionHeader(
                  context, 
                  "Main Menu", 
                  onSeeAll: () {},
                ),
                const SizedBox(height: 16),
                _buildFeatureGrid(context),
                const SizedBox(height: 30),
                // _buildSectionHeader(
                //   context, 
                //   "Your Attendance", 
                //   onSeeAll: () {},
                // ),
                // const SizedBox(height: 16),
                // _buildAttendanceHistory(context),
                // const SizedBox(height: 30),
                _buildSectionHeader(
                  context, 
                  "New Employees", 
                  onSeeAll: () {},
                ),
                const SizedBox(height: 16),
                _buildNewEmployees(context),
                const SizedBox(height: 30),
                _buildSectionHeader(
                  context, 
                  "Announcements", 
                  onSeeAll: () {
                    // Navigate to Timeline tab with Announcement sub-tab selected
                    widget.onNavigateToTimeline?.call(1);
                  },
                ),
                const SizedBox(height: 16),
                _buildAnnouncements(context),
                const SizedBox(height: 30),
                _buildSectionHeader(
                  context, 
                  "Terms & Policy", 
                  onSeeAll: () {
                    // Navigate to Timeline tab with Terms & Policy sub-tab selected
                    widget.onNavigateToTimeline?.call(2);
                  },
                ),
                const SizedBox(height: 16),
                _buildTermsPolicy(context),
                const SizedBox(height: 120),
              ],
            ),
          ),
          // Sticky company selector only
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: _buildCompanySelector(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceInfo(BuildContext context) {
    return Material(
      color: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
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
                  color: Theme.of(context).colorScheme.primaryContainer,
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
    final bgColor = _companyBgColor ?? Theme.of(context).colorScheme.primaryContainer;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showCompanyBottomSheet(context),
        borderRadius: BorderRadius.circular(32),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
                border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: bgColor.withOpacity(0.25),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: bgColor.withOpacity(0.5),
                      backgroundImage: NetworkImage(_selectedCompany['logo']!),
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
                          _loadCompanyColor();
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
                                : Theme.of(context).colorScheme.primary.withOpacity(0.12),
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
      padding: EdgeInsets.zero, // This removes the bottom gap
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
              color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
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
  Widget _buildAttendanceHistory(BuildContext context) {
    return Column(
      children: _attendanceHistory.map((history) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Material(
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
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history['date']!,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Present",
                          style: Theme.of(context).textTheme.bodyMedium
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildHistoryTimeItem(context, "Clock In", history['clockIn']!),
                        const SizedBox(width: 24),
                        Container(width: 1, height: 40, color: Theme.of(context).colorScheme.shadow),
                        const SizedBox(width: 24),
                        _buildHistoryTimeItem(context, "Clock Out", history['clockOut']!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (onSeeAll != null)
            Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: onSeeAll,
                borderRadius: BorderRadius.circular(48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "See All",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryTimeItem(BuildContext context, String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _buildNewEmployees(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _newEmployees.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final employee = _newEmployees[index];
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
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 30),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      employee['name']!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee['role']!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            fontSize: 11,
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

  Widget _buildAnnouncements(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _announcements.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
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
              child: Container(
                width: 220,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: priorityColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            announcement['title']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        announcement['description']!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      announcement['date']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                            fontSize: 10,
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

  Widget _buildTermsPolicy(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _termsPolicy.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
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
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.description,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'v${policy['version']!}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      policy['title']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        policy['description']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Updated: ${policy['lastUpdated']!}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                            fontSize: 10,
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
