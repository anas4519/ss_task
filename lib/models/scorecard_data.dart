class ScorecardData {
  String workOrderNo;
  DateTime date;
  String nameOfWork;
  String contractor;
  String supervisor;
  String designation;
  String inspectionDate;
  String trainNo;
  String arrivalTime;
  String departureTime;
  int totalCoaches;
  double totalScorePercentage;
  bool isAccessible;

  Map<String, ActivityScore> activityScores;

  ScorecardData({
    this.workOrderNo = '',
    DateTime? date,
    this.nameOfWork = '',
    this.contractor = '',
    this.supervisor = '',
    this.designation = '',
    this.inspectionDate = '',
    this.trainNo = '',
    this.arrivalTime = '',
    this.departureTime = '',
    this.totalCoaches = 0,
    this.totalScorePercentage = 0.0,
    this.isAccessible = false,
    Map<String, ActivityScore>? activityScores,
  })  : date = date ?? DateTime.now(),
        activityScores = activityScores ?? _initializeActivityScores();

  static Map<String, ActivityScore> _initializeActivityScores() {
    return {
      'toilet_cleaning': ActivityScore(
        activityName:
            'Toilet complete cleaning including pan with High Jet machine',
      ),
      'outside_washbasin': ActivityScore(
        activityName:
            'Cleaning & wiping of outside washbasin, mirror & shelves in doorway area',
      ),
      'vestibule_area': ActivityScore(
        activityName:
            'Vestibule area, Doorway area, area between two toilets and footsteps',
      ),
      'waste_disposal': ActivityScore(
        activityName: 'Disposal of collected waste from Coaches & AC Bins',
      ),
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> activityScoresJson = {};
    activityScores.forEach((key, value) {
      activityScoresJson[key] = value.toJson();
    });

    return {
      'workOrderNo': workOrderNo,
      'date': date.toIso8601String(),
      'nameOfWork': nameOfWork,
      'contractor': contractor,
      'supervisor': supervisor,
      'designation': designation,
      'inspectionDate': inspectionDate,
      'trainNo': trainNo,
      'arrivalTime': arrivalTime,
      'departureTime': departureTime,
      'totalCoaches': totalCoaches,
      'totalScorePercentage': totalScorePercentage,
      'isAccessible': isAccessible,
      'activityScores': activityScoresJson,
    };
  }
}

class ActivityScore {
  String activityName;
  Map<String, String?> scores;
  String remarks;

  ActivityScore({
    required this.activityName,
    Map<String, String?>? scores,
    this.remarks = '',
  }) : this.scores = scores ?? {};

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'scores': scores,
      'remarks': remarks,
    };
  }

  double getAverageScore() {
    var validScores = scores.values
        .where((score) => score != null && score != 'X' && score != '-')
        .map((score) => int.tryParse(score!) ?? 0)
        .toList();

    if (validScores.isEmpty) return 0.0;
    return validScores.reduce((a, b) => a + b) / validScores.length;
  }
}
