import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/scorecard_provider.dart';
import '../widgets/custom_text_field.dart';

class BasicInfoTab extends StatefulWidget {
  const BasicInfoTab({super.key});

  @override
  State<BasicInfoTab> createState() => _BasicInfoTabState();
}

class _BasicInfoTabState extends State<BasicInfoTab> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _inspectionDateController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _departureTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScorecardProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            _buildSectionHeader(theme, 'Work Order Information'),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'W.O No.',
                    onChanged: (value) {
                      provider.updateBasicInfo(workOrderNo: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter W.O No.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Date',
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, _dateController, (date) {
                      provider.updateBasicInfo(date: date);
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select date';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Name of Work - Full width
            CustomTextField(
              label: 'Name of Work',
              onChanged: (value) {
                provider.updateBasicInfo(nameOfWork: value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Name of Work';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Contractor - Full width
            CustomTextField(
              label: 'Name of Contractor',
              onChanged: (value) {
                provider.updateBasicInfo(contractor: value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Contractor';
                }
                return null;
              },
            ),
            SizedBox(height: 24),

            // Section Header
            _buildSectionHeader(theme, 'Supervisor Information'),
            SizedBox(height: 16),

            // Supervisor Name - Full width
            CustomTextField(
              label: 'Name of Supervisor',
              onChanged: (value) {
                provider.updateBasicInfo(supervisor: value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Supervisor';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Designation and Inspection Date in a row
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Designation',
                    onChanged: (value) {
                      provider.updateBasicInfo(designation: value);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Inspection Date',
                    controller: _inspectionDateController,
                    readOnly: true,
                    onTap: () =>
                        _selectDate(context, _inspectionDateController, (date) {
                      provider.updateBasicInfo(
                          inspectionDate: _inspectionDateController.text);
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Section Header
            _buildSectionHeader(theme, 'Train Information'),
            SizedBox(height: 16),

            // Train No. - Full width
            CustomTextField(
              label: 'Train No.',
              onChanged: (value) {
                provider.updateBasicInfo(trainNo: value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Train No.';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Arrival and Departure Time in a row
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Arrival Time',
                    controller: _arrivalTimeController,
                    readOnly: true,
                    onTap: () =>
                        _selectTime(context, _arrivalTimeController, (time) {
                      provider.updateBasicInfo(
                          arrivalTime: _arrivalTimeController.text);
                    }),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Departure Time',
                    controller: _departureTimeController,
                    readOnly: true,
                    onTap: () =>
                        _selectTime(context, _departureTimeController, (time) {
                      provider.updateBasicInfo(
                          departureTime: _departureTimeController.text);
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Coaches attended - Full width
            CustomTextField(
              label: 'No. of Coaches attended by contractor',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final coaches = int.tryParse(value) ?? 0;
                provider.updateBasicInfo(totalCoaches: coaches);
              },
            ),
            SizedBox(height: 16),

            // Total coaches - Full width
            CustomTextField(
              label: 'Total No. of Coaches in the train',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Additional field if needed
              },
            ),
            SizedBox(height: 24),

            // Score Summary Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Score',
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${provider.scorecardData.totalScorePercentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            CupertinoIcons.chart_bar_fill,
                            color: theme.primaryColor,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mark as Inaccessible',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          value: provider.scorecardData.isAccessible,
                          onChanged: (value) {
                            provider.updateBasicInfo(isAccessible: value);
                          },
                          activeColor: theme.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32), // Extra space at bottom for easy scrolling
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
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
            CupertinoIcons.doc_text_fill,
            size: 18,
            color: theme.primaryColor,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    Function(DateTime) onDateSelected,
  ) async {
    final theme = Theme.of(context);
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(date);
      onDateSelected(date);
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
    Function(TimeOfDay) onTimeSelected,
  ) async {
    final theme = Theme.of(context);
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (time != null) {
      controller.text = time.format(context);
      onTimeSelected(time);
    }
  }
}
