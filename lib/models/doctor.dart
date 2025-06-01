class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String polyclinicId;
  final String bio;
  final String imageUrl;
  final List<Schedule> schedules;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.polyclinicId,
    required this.bio,
    required this.imageUrl,
    required this.schedules,
  });
}

class Schedule {
  final String day;
  final String startTime;
  final String endTime;
  final int maxPatients;
  final List<String> bookedSlots;

  Schedule({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.maxPatients,
    required this.bookedSlots,
  });
}
