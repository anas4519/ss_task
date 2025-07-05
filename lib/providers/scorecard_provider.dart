import 'package:flutter/material.dart';
import '../models/scorecard_data.dart';

class ScorecardProvider extends ChangeNotifier {
  ScorecardData _scorecardData = ScorecardData();

  ScorecardData get scorecardData => _scorecardData;

  void updateBasicInfo({
    String? workOrderNo,
    DateTime? date,
    String? nameOfWork,
    String? contractor,
    String? supervisor,
    String? designation,
    String? inspectionDate,
    String? trainNo,
    String? arrivalTime,
    String? departureTime,
    int? totalCoaches,
    bool? isAccessible,
  }) {
    if (workOrderNo != null) _scorecardData.workOrderNo = workOrderNo;
    if (date != null) _scorecardData.date = date;
    if (nameOfWork != null) _scorecardData.nameOfWork = nameOfWork;
    if (contractor != null) _scorecardData.contractor = contractor;
    if (supervisor != null) _scorecardData.supervisor = supervisor;
    if (designation != null) _scorecardData.designation = designation;
    if (inspectionDate != null) _scorecardData.inspectionDate = inspectionDate;
    if (trainNo != null) _scorecardData.trainNo = trainNo;
    if (arrivalTime != null) _scorecardData.arrivalTime = arrivalTime;
    if (departureTime != null) _scorecardData.departureTime = departureTime;
    if (totalCoaches != null) _scorecardData.totalCoaches = totalCoaches;
    if (isAccessible != null) _scorecardData.isAccessible = isAccessible;
    notifyListeners();
  }

  void updateActivityScore(String activityKey, String scoreKey, String? score) {
    if (_scorecardData.activityScores.containsKey(activityKey)) {
      _scorecardData.activityScores[activityKey]!.scores[scoreKey] = score;
      _calculateTotalScore();
      notifyListeners();
    }
  }

  String? getActivityScore(String activityKey, String scoreKey) {
    if (_scorecardData.activityScores.containsKey(activityKey)) {
      return _scorecardData.activityScores[activityKey]!.scores[scoreKey];
    }
    return null;
  }

  void updateActivityRemarks(String activityKey, String remarks) {
    if (_scorecardData.activityScores.containsKey(activityKey)) {
      _scorecardData.activityScores[activityKey]!.remarks = remarks;
      notifyListeners();
    }
  }

  void _calculateTotalScore() {
    double totalScore = 0;
    int totalCount = 0;

    _scorecardData.activityScores.forEach((activityKey, activityScore) {
      activityScore.scores.forEach((scoreKey, score) {
        if (score != null && score != 'X' && score != '-') {
          int? numericScore = int.tryParse(score);
          if (numericScore != null) {
            totalScore += numericScore;
            totalCount++;
          }
        }
      });
    });

    if (totalCount > 0) {
      _scorecardData.totalScorePercentage =
          (totalScore / (totalCount * 10)) * 100;
    } else {
      _scorecardData.totalScorePercentage = 0;
    }
  }

  bool validateForm() {
    return _scorecardData.workOrderNo.isNotEmpty &&
        _scorecardData.nameOfWork.isNotEmpty &&
        _scorecardData.contractor.isNotEmpty &&
        _scorecardData.supervisor.isNotEmpty &&
        _scorecardData.trainNo.isNotEmpty;
  }

  void resetForm() {
    _scorecardData = ScorecardData();
    notifyListeners();
  }
}
