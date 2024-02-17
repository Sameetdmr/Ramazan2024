import 'package:flutter/material.dart';

enum TabItem { home, calendar }

const Map<TabItem, IconData> tabIcons = {
  TabItem.home: Icons.home_outlined,
  TabItem.calendar: Icons.calendar_month_outlined,
};

class CustomBottomNavigation extends StatelessWidget {
  CustomBottomNavigation({
    Key? key,
    required this.onSelectedTab,
    required this.tabController,
  }) : super(key: key);
  final ValueChanged<TabItem> onSelectedTab;
  final TabController tabController;

  static const _notcMarginSize = 10.0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: _notcMarginSize,
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.blue,
        labelPadding: EdgeInsets.zero,
        onTap: (value) {
          onSelectedTab(TabItem.values[value]);
        },
        tabs: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.calendar),
        ],
      ),
    );
  }

  Tab _buildItem(TabItem tabItem) {
    return Tab(
      iconMargin: EdgeInsets.zero,
      icon: Icon(
        tabIcons[tabItem],
        color: Colors.black,
      ),
    );
  }
}
