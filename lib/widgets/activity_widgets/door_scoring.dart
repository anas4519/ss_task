import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ss_task/widgets/activity_widgets/score_dropdown.dart';

class DoorScoring extends StatelessWidget {
  final String activityKey;
  const DoorScoring({super.key, required this.activityKey});

  @override
  Widget build(BuildContext context) {
    final doors = ['B1', 'B2', 'D1', 'D2'];
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
                CupertinoIcons.rectangle_split_3x3,
                size: 20,
                color: theme.primaryColor,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Door & Vestibule Scoring',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      'Rate doors/vestibules in all coaches',
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

        // Coaches list
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
                      Spacer(),
                      // Progress indicator
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '0/4', // Update based on actual scores
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Doors grid
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Door type indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildDoorTypeIndicator(theme, 'B', 'Vestibule'),
                            _buildDoorTypeIndicator(theme, 'D', 'Doorway'),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Score dropdowns grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenWidth < 360 ? 2 : 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: doors.length,
                          itemBuilder: (context, index) {
                            final door = doors[index];
                            final scoreKey = 'C$coachNumber-$door';
                            final isVestibule = door.startsWith('B');

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isVestibule
                                        ? Colors.purple.withOpacity(0.1)
                                        : Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    door,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isVestibule
                                          ? Colors.purple
                                          : Colors.orange,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        // Summary info with legend
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.info_circle,
                    size: 14,
                    color: theme.primaryColor,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '13 coaches × 4 doors = 52 items',
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _buildLegendItem('B1-B2', 'Vestibule', Colors.purple),
                  SizedBox(width: 16),
                  _buildLegendItem('D1-D2', 'Doorway', Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDoorTypeIndicator(ThemeData theme, String prefix, String label) {
    final color = prefix == 'B' ? Colors.purple : Colors.orange;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: theme.colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String code, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 4),
        Text(
          '= $label',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
