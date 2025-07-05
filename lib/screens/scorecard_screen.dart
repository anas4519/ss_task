import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'basic_info_tab.dart';
import 'activities_tab.dart';
import 'review_tab.dart';

class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  int _currIndex = 0;

  final List<Widget> pages = [
    BasicInfoTab(),
    ActivitiesTab(),
    ReviewTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Train Station Scorecard'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currIndex,
              children: pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: GNav(
              onTabChange: (index) {
                setState(() {
                  _currIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              color: theme.colorScheme.onSurface.withOpacity(0.65),
              activeColor: isDarkTheme ? Colors.white : theme.primaryColor,
              tabBackgroundColor: theme.primaryColor.withOpacity(0.15),
              tabBorderRadius: 24,
              gap: 8,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              tabs: [
                GButton(
                  icon: CupertinoIcons.info_circle_fill,
                  text: 'Basic Info',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.white : theme.primaryColor,
                  ),
                ),
                GButton(
                  icon: CupertinoIcons.list_bullet,
                  text: 'Activities',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.white : theme.primaryColor,
                  ),
                ),
                GButton(
                  icon: CupertinoIcons.checkmark_circle_fill,
                  text: 'Review',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? Colors.white : theme.primaryColor,
                  ),
                ),
              ],
              selectedIndex: _currIndex,
              rippleColor: theme.primaryColor.withOpacity(0.2),
              hoverColor: theme.primaryColor.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }
}
