enum AppointmentStatus { confirmed, cancelled, completed }

class Appointment {
  final String id;
  final String userId;
  final String doctorId;
  final String doctorName;
  final String polyclinicName;
  final DateTime date;
  final String time;
  final String queueNumber;
  final String reasonForVisit;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.polyclinicName,
    required this.date,
    required this.time,
    required this.queueNumber,
    required this.reasonForVisit,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      userId: json['userId'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      polyclinicName: json['polyclinicName'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      queueNumber: json['queueNumber'],
      reasonForVisit: json['reasonForVisit'],
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${json['status']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'polyclinicName': polyclinicName,
      'date': date.toIso8601String(),
      'time': time,
      'queueNumber': queueNumber,
      'reasonForVisit': reasonForVisit,
      'status': status.toString().split('.').last,
    };
  }
}
