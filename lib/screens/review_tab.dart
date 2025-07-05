import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/scorecard_provider.dart';
import '../services/api_service.dart';
import '../widgets/review_row.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScorecardProvider>(context);
    final data = provider.scorecardData;
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
                  CupertinoIcons.doc_checkmark_fill,
                  color: theme.primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Review Form Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Basic Information Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basic Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 12),
                  ReviewRow(label: 'W.O No.', value: data.workOrderNo),
                  ReviewRow(label: 'Name of Work', value: data.nameOfWork),
                  ReviewRow(label: 'Contractor', value: data.contractor),
                  ReviewRow(label: 'Supervisor', value: data.supervisor),
                  ReviewRow(label: 'Train No.', value: data.trainNo),
                  ReviewRow(label: 'Arrival Time', value: data.arrivalTime),
                  ReviewRow(label: 'Departure Time', value: data.departureTime),
                  ReviewRow(
                    label: 'Total Score',
                    value: '${data.totalScorePercentage.toStringAsFixed(1)}%',
                    valueColor: theme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Activity Scores Summary
          Text(
            'Activity Scores Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground,
            ),
          ),
          SizedBox(height: 8),
          ...data.activityScores.entries.map((entry) {
            final avgScore = entry.value.getAverageScore();
            final scoredItems = entry.value.scores.values
                .where((s) => s != null && s != '-')
                .length;
            final totalItems = entry.value.scores.length;

            return Card(
              margin: EdgeInsets.only(bottom: 12),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  entry.value.activityName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      'Average Score: ${avgScore.toStringAsFixed(1)}/10',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Scored: $scoredItems/$totalItems items',
                      style: TextStyle(fontSize: 12),
                    ),
                    if (entry.value.remarks.isNotEmpty)
                      Text(
                        'Remarks: ${entry.value.remarks}',
                        style: TextStyle(
                            fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                  ],
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getScoreColor(avgScore).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${avgScore.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: _getScoreColor(avgScore),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          SizedBox(height: 24),

          SizedBox(height: 24),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (provider.validateForm()) {
                  _submitForm(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.paperplane_fill),
                    SizedBox(width: 8),
                    Text(
                      'Submit Form',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 8) return Colors.green;
    if (score >= 6) return Colors.orange;
    return Colors.red;
  }

  void _submitForm(BuildContext context) async {
    final provider = Provider.of<ScorecardProvider>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final success = await ApiService.submitScorecard(provider.scorecardData);
      Navigator.pop(context); // Close loading dialog

      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.green),
                SizedBox(width: 8),
                Text('Success'),
              ],
            ),
            content: Text('Scorecard submitted successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  provider.resetForm();
                },
                child: Text('OK'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit scorecard'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
