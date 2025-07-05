import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ss_task/widgets/activity_widgets/score_dropdown.dart';

class CoachScoring extends StatelessWidget {
  final String activityKey;
  const CoachScoring({super.key, required this.activityKey});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    double itemWidth = (screenWidth - 48) / 4;
    if (screenWidth < 360) {
      itemWidth = (screenWidth - 48) / 3;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with icon
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColor.withOpacity(0.1),
                theme.primaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: theme.primaryColor,
                width: 4,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.train_style_one,
                size: 20,
                color: theme.primaryColor,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coach-wise Scoring',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      'Rate each of the 13 coaches',
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Coaches grid
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.3),
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 12,
            children: List.generate(13, (index) {
              final coachNumber = index + 1;
              final scoreKey = 'C$coachNumber';

              return Container(
                width: itemWidth.clamp(70, 100), // Min 70, max 100
                child: _buildCoachItem(
                  theme,
                  coachNumber,
                  scoreKey,
                  activityKey,
                ),
              );
            }),
          ),
        ),

        // Summary info
        Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.primaryColor.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.info_circle,
                size: 14,
                color: theme.primaryColor,
              ),
              SizedBox(width: 6),
              Text(
                'Quick scoring for 13 coaches',
                style: TextStyle(
                  fontSize: 11,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoachItem(
    ThemeData theme,
    int coachNumber,
    String scoreKey,
    String activityKey,
  ) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withOpacity(0.8),
                  theme.primaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$coachNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          ScoreDropdown(
            activityKey: activityKey,
            scoreKey: scoreKey,
          ),
        ],
      ),
    );
  }
}
