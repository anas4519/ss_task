import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ss_task/widgets/activity_widgets/score_dropdown.dart';

class ToiletScoring extends StatelessWidget {
  final String activityKey;
  const ToiletScoring({super.key, required this.activityKey});

  @override
  Widget build(BuildContext context) {
    final toilets = ['T1', 'T2', 'T3', 'T4'];
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

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
                CupertinoIcons.square_grid_2x2_fill,
                size: 20,
                color: theme.primaryColor,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toilet Scoring Grid',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      'Rate each toilet in all coaches',
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

        // Coaches list - Simple version without expansion tiles
        ...List.generate(13, (coachIndex) {
          final coachNumber = coachIndex + 1;
          final isEven = coachIndex % 2 == 0;

          return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isEven
                  ? theme.cardColor
                  : theme.primaryColor.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.5),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coach header
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '$coachNumber',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Coach $coachNumber',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Toilets grid - Responsive layout
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth < 360 ? 2 : 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: toilets.length,
                      itemBuilder: (context, index) {
                        final toilet = toilets[index];
                        final scoreKey = 'C$coachNumber-$toilet';

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                toilet,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Expanded(
                              child: ScoreDropdown(
                                activityKey: activityKey,
                                scoreKey: scoreKey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        // Summary info
        Container(
          margin: EdgeInsets.only(top: 8),
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
              Expanded(
                child: Text(
                  '13 coaches × 4 toilets = 52 items',
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
