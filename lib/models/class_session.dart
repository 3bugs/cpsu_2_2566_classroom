class ClassSession {
  final String date;
  final bool? status;
  final bool canCheckIn;

  ClassSession({
    required this.date,
    required this.status,
    required this.canCheckIn,
  });

  factory ClassSession.fromJson(Map<String, dynamic> json) {
    return ClassSession(
      date: json['date'],
      status: json['status'],
      canCheckIn: json['canCheckIn'],
    );
  }

  void checkIn() {
    
  }
}
