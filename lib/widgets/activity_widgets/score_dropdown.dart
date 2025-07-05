import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_task/providers/scorecard_provider.dart';

class ScoreDropdown extends StatelessWidget {
  final String activityKey;
  final String scoreKey;
  const ScoreDropdown({
    super.key,
    required this.activityKey,
    required this.scoreKey,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScorecardProvider>(context);
    final theme = Theme.of(context);
    final currentValue = provider.getActivityScore(activityKey, scoreKey);

    Color? valueColor;
    if (currentValue != null && currentValue != '-') {
      if (currentValue == 'X') {
        valueColor = Colors.red;
      } else {
        final score = int.tryParse(currentValue) ?? 0;
        if (score >= 8) {
          valueColor = Colors.green;
        } else if (score >= 5) {
          valueColor = Colors.orange;
        } else if (score > 0) {
          valueColor = Colors.red;
        }
      }
    }

    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: valueColor?.withOpacity(0.5) ?? theme.dividerColor,
          width: valueColor != null ? 1.5 : 1,
        ),
        color: valueColor?.withOpacity(0.05) ?? theme.cardColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          isDense: true,
          isExpanded: true,
          alignment: Alignment.center,
          menuMaxHeight: 300,
          borderRadius: BorderRadius.circular(8),
          dropdownColor: theme.cardColor,
          elevation: 4,
          style: TextStyle(
            color: valueColor ?? theme.colorScheme.onBackground,
            fontSize: 13,
            fontWeight: currentValue != null && currentValue != '-'
                ? FontWeight.w600
                : FontWeight.normal,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            size: 18,
            color: theme.colorScheme.onBackground.withOpacity(0.5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6),
          items: [
            DropdownMenuItem(
              value: null,
              child: Center(
                child: Text(
                  '-',
                  style: TextStyle(
                    color: theme.colorScheme.onBackground.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'X',
              child: Center(
                child: Text(
                  'X',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...List.generate(11, (i) => i).map((score) {
              Color scoreColor = theme.colorScheme.onBackground;
              if (score >= 8) {
                scoreColor = Colors.green;
              } else if (score >= 5) {
                scoreColor = Colors.orange;
              } else if (score > 0) {
                scoreColor = Colors.red;
              }

              return DropdownMenuItem<String>(
                value: score.toString(),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: scoreColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        score.toString(),
                        style: TextStyle(
                          color: scoreColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
          onChanged: (value) {
            provider.updateActivityScore(activityKey, scoreKey, value);
          },
        ),
      ),
    );
  }
}
