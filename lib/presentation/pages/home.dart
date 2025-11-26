import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'home_tab.dart';
import 'timeline/timeline_tab_page.dart';
import 'timeline/new_post_page.dart';
import 'notification_tab.dart';
import 'profile_tab.dart';
import 'record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  String titlePage = "Home";
  int? _timelineInitialTabIndex;
  int _timelineSubTabIndex = 0; // Track which sub-tab is active in Timeline

  void navigateToTimelineTab(int tabIndex) {
    setState(() {
      currentPageIndex = 1;
      titlePage = "Timeline";
      _timelineInitialTabIndex = tabIndex;
      _timelineSubTabIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      extendBody: true,
        appBar: AppBar(
          title: Text(titlePage),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          actions: currentPageIndex == 1 && _timelineSubTabIndex == 0
              ? [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewPostPage(),
                        ),
                      );
                    },
                  ),
                ]
              : null,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Home
                  _buildNavItem(
                    context,
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    isSelected: currentPageIndex == 0,
                    onTap: () => setState(() {
                      currentPageIndex = 0;
                      titlePage = "Home";
                    }),
                  ),
                  
                  // Timeline
                  _buildNavItem(
                    context,
                    icon: Icons.timeline_outlined,
                    selectedIcon: Icons.timeline,
                    isSelected: currentPageIndex == 1,
                    onTap: () => setState(() {
                      currentPageIndex = 1;
                      titlePage = "Timeline";
                    }),
                  ),
                  
                  // Record (placeholder - same size as other items for equal spacing)
                  const SizedBox(width: 64, height: 64),
                  
                  // Notification
                  _buildNavItem(
                    context,
                    icon: Icons.notifications_outlined,
                    selectedIcon: Icons.notifications,
                    isSelected: currentPageIndex == 3,
                    onTap: () => setState(() {
                      currentPageIndex = 3;
                      titlePage = "Notification";
                    }),
                  ),
                  
                  // Profile
                  _buildNavItem(
                    context,
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    isSelected: currentPageIndex == 4,
                    onTap: () => setState(() {
                      currentPageIndex = 4;
                      titlePage = "Profile";
                    }),
                  ),
                ],
              ),
            ),

            
            // Prominent Record Tab (matches nav items but larger & accented)
            Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RecordPage()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.60),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.10),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 36,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Builder(
            builder: (_) {
              if (currentPageIndex == 0) {
                return HomeTab(
                  onNavigateToTimeline: navigateToTimelineTab,
                );
              }
              if (currentPageIndex == 1) {
                final widget = TimelineTabPage(
                  initialTabIndex: _timelineInitialTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _timelineSubTabIndex = index;
                    });
                  },
                );
                // Reset the initial tab index after building
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _timelineInitialTabIndex = null;
                    });
                  }
                });
                return widget;
              }
              if (currentPageIndex == 3) return const NotificationTab();
              if (currentPageIndex == 4) return const ProfileTab();

              return const SizedBox.shrink();
            },
          ),
        )
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final neutralColor = Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2);
    final accentColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(0.25);
    final bgColor = isSelected ? accentColor : neutralColor;
    final iconColor = isSelected 
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    final useIcon = isSelected ? selectedIcon : icon;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              useIcon,
              size: 32,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

}