import 'package:flutter/material.dart';
import 'timeline_content_tab.dart';
import 'announcement_tab.dart';
import 'terms_policy_tab.dart';

class TimelineTabPage extends StatefulWidget {
  const TimelineTabPage({super.key});

  @override
  State<TimelineTabPage> createState() => _TimelineTabPageState();
}

class _TimelineTabPageState extends State<TimelineTabPage> {
  int selectedTabIndex = 0;
  late PageController _pageController;
  late ScrollController _tabScrollController;
  final List<GlobalKey> _tabKeys = List.generate(3, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedTabIndex);
    _tabScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  void scrollToSelectedTab() {
    final keyContext = _tabKeys[selectedTabIndex].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }

  void changeTab(int index) {
    setState(() => selectedTabIndex = index);
    _pageController.jumpToPage(index);
    scrollToSelectedTab();
  }

  Widget buildTab(String label, int index, {Key? key}) {
    final isSelected = selectedTabIndex == index;
    return Container(
      key: key,
      child: GestureDetector(
        onTap: () => changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          margin: EdgeInsets.only(right: index != 2 ? 12 : 0),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).iconTheme.color
                : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).iconTheme.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 16,
              right: 16,
            ),
            controller: _tabScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildTab("Timeline", 0, key: _tabKeys[0]),
                buildTab("Announcement", 1, key: _tabKeys[1]),
                buildTab("Terms & Policy", 2, key: _tabKeys[2]),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => selectedTabIndex = index);
                scrollToSelectedTab();
              },
              children: const [
                TimelineContentTab(),
                AnnouncementTab(),
                TermsPolicyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
