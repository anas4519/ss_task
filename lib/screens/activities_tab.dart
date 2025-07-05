import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ss_task/widgets/activity_widgets/coach_scoring.dart';
import 'package:ss_task/widgets/activity_widgets/door_scoring.dart';
import 'package:ss_task/widgets/activity_widgets/toilet_scoring.dart';
import '../providers/scorecard_provider.dart';

class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.list_bullet,
                  color: theme.primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'CLEAN TRAIN STATION ACTIVITIES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Activity 1: Toilet cleaning (T1, T2, T3, T4 for each of 13 coaches)
          _buildActivitySection(
            context: context,
            theme: theme,
            slNo: '1',
            title:
                'Toilet complete cleaning including pan with High Jet machine',
            description:
                'Machine cleaning wiping of wash basin, mirror & fittings, Spraying of Air Freshener & Mosquito Repellant',
            activityKey: 'toilet_cleaning',
            scoreType: 'toilets',
          ),

          // Activity 2: Outside washbasin cleaning (for each of 13 coaches)
          _buildActivitySection(
            context: context,
            theme: theme,
            slNo: '2',
            title:
                'Cleaning & wiping of outside washbasin, mirror & shelves in doorway area',
            description:
                'Clean and wipe all outside washbasins, mirrors, and shelves in doorway area',
            activityKey: 'outside_washbasin',
            scoreType: 'coaches',
          ),

          // Activity 3: Vestibule area (B1, B2, D1, D2 for each of 13 coaches)
          _buildActivitySection(
            context: context,
            theme: theme,
            slNo: '3',
            title:
                'Vestibule area, Doorway area, area between two toilets and footsteps',
            description:
                'Clean vestibule areas, doorways, areas between toilets and footsteps',
            activityKey: 'vestibule_area',
            scoreType: 'doors',
          ),

          // Activity 4: Waste disposal (for each of 13 coaches)
          _buildActivitySection(
            context: context,
            theme: theme,
            slNo: '4',
            title: 'Disposal of collected waste from Coaches & AC Bins',
            description:
                'Proper disposal of all collected waste from coaches and AC bins',
            activityKey: 'waste_disposal',
            scoreType: 'coaches',
          ),

          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.info_circle_fill,
                        color: Colors.amber[700], size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Important Note',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Please give marks for each item on a scale 0 to 10. All items that are inaccessible should be marked \'X\' and shall not be counted in total score. Items not available should be marked \'-\'. No column should be left blank.',
                  style: TextStyle(fontSize: 12, color: Colors.amber[900]),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildActivitySection({
    required BuildContext context,
    required ThemeData theme,
    required String slNo,
    required String title,
    required String description,
    required String activityKey,
    required String scoreType,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        slNo,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                theme.colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),

              // Scoring section based on type
              if (scoreType == 'toilets')
                ToiletScoring(activityKey: activityKey),
              if (scoreType == 'coaches')
                CoachScoring(activityKey: activityKey),
              if (scoreType == 'doors') DoorScoring(activityKey: activityKey),

              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  labelStyle: TextStyle(
                      color: theme.colorScheme.onBackground.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefixIcon:
                      Icon(CupertinoIcons.pencil, color: theme.primaryColor),
                ),
                style: TextStyle(color: theme.colorScheme.onBackground),
                onChanged: (value) {
                  Provider.of<ScorecardProvider>(context, listen: false)
                      .updateActivityRemarks(activityKey, value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
