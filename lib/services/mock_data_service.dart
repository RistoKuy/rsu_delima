import '../models/user.dart';
import '../models/doctor.dart';
import '../models/polyclinic.dart';
import '../models/appointment.dart';

class MockDataService {
  static User? currentUser;

  static final List<Polyclinic> polyclinics = [
    Polyclinic(
      id: '1',
      name: 'General Medicine',
      description: 'General healthcare and consultation',
      iconName: 'medical_services',
    ),
    Polyclinic(
      id: '2',
      name: 'Dental',
      description: 'Dental care and oral health',
      iconName: 'healing',
    ),
    Polyclinic(
      id: '3',
      name: 'Obstetrics & Gynecology',
      description: 'Women\'s health and pregnancy care',
      iconName: 'pregnant_woman',
    ),
    Polyclinic(
      id: '4',
      name: 'Internal Medicine',
      description: 'Internal organ diseases and disorders',
      iconName: 'local_hospital',
    ),
  ];

  static final List<Doctor> doctors = [
    Doctor(
      id: '1',
      name: 'Dr. John Smith',
      specialty: 'General Practitioner',
      polyclinicId: '1',
      bio: 'Experienced general practitioner with 10+ years of experience.',
      imageUrl: 'https://via.placeholder.com/150',
      schedules: [
        Schedule(
          day: 'Monday',
          startTime: '08:00',
          endTime: '15:00',
          maxPatients: 20,
          bookedSlots: ['08:00', '09:00', '10:00'],
        ),
        Schedule(
          day: 'Tuesday',
          startTime: '08:00',
          endTime: '15:00',
          maxPatients: 20,
          bookedSlots: ['08:00', '11:00'],
        ),
        Schedule(
          day: 'Wednesday',
          startTime: '08:00',
          endTime: '15:00',
          maxPatients: 20,
          bookedSlots: ['09:00', '14:00'],
        ),
      ],
    ),
    Doctor(
      id: '2',
      name: 'Dr. Sarah Johnson',
      specialty: 'General Practitioner',
      polyclinicId: '1',
      bio: 'Caring doctor focused on preventive care and patient education.',
      imageUrl: 'https://via.placeholder.com/150',
      schedules: [
        Schedule(
          day: 'Monday',
          startTime: '13:00',
          endTime: '20:00',
          maxPatients: 15,
          bookedSlots: ['13:00', '15:00'],
        ),
        Schedule(
          day: 'Thursday',
          startTime: '08:00',
          endTime: '15:00',
          maxPatients: 15,
          bookedSlots: ['10:00'],
        ),
      ],
    ),
    Doctor(
      id: '3',
      name: 'Dr. Michael Brown',
      specialty: 'Dentist',
      polyclinicId: '2',
      bio: 'Specialist in dental care and oral surgery.',
      imageUrl: 'https://via.placeholder.com/150',
      schedules: [
        Schedule(
          day: 'Tuesday',
          startTime: '09:00',
          endTime: '17:00',
          maxPatients: 12,
          bookedSlots: ['09:00', '11:00', '14:00'],
        ),
        Schedule(
          day: 'Friday',
          startTime: '09:00',
          endTime: '17:00',
          maxPatients: 12,
          bookedSlots: ['15:00'],
        ),
      ],
    ),
    Doctor(
      id: '4',
      name: 'Dr. Emily Davis',
      specialty: 'Obstetrician & Gynecologist',
      polyclinicId: '3',
      bio: 'Specialized in women\'s health and prenatal care.',
      imageUrl: 'https://via.placeholder.com/150',
      schedules: [
        Schedule(
          day: 'Wednesday',
          startTime: '10:00',
          endTime: '16:00',
          maxPatients: 10,
          bookedSlots: ['10:00', '12:00'],
        ),
        Schedule(
          day: 'Saturday',
          startTime: '08:00',
          endTime: '14:00',
          maxPatients: 8,
          bookedSlots: ['08:00'],
        ),
      ],
    ),
    Doctor(
      id: '5',
      name: 'Dr. Robert Wilson',
      specialty: 'Internal Medicine Specialist',
      polyclinicId: '4',
      bio: 'Expert in diagnosing and treating internal medicine conditions.',
      imageUrl: 'https://via.placeholder.com/150',
      schedules: [
        Schedule(
          day: 'Monday',
          startTime: '07:00',
          endTime: '14:00',
          maxPatients: 16,
          bookedSlots: ['07:00', '09:00', '11:00'],
        ),
        Schedule(
          day: 'Thursday',
          startTime: '07:00',
          endTime: '14:00',
          maxPatients: 16,
          bookedSlots: ['08:00', '13:00'],
        ),
      ],
    ),
  ];

  static List<Appointment> appointments = [
    Appointment(
      id: '1',
      userId: 'user123',
      doctorId: '1',
      doctorName: 'Dr. John Smith',
      polyclinicName: 'General Medicine',
      date: DateTime.now().add(const Duration(days: 2)),
      time: '09:00',
      queueNumber: 'A001',
      reasonForVisit: 'Regular checkup',
      status: AppointmentStatus.confirmed,
    ),
    Appointment(
      id: '2',
      userId: 'user123',
      doctorId: '3',
      doctorName: 'Dr. Michael Brown',
      polyclinicName: 'Dental',
      date: DateTime.now().subtract(const Duration(days: 5)),
      time: '14:00',
      queueNumber: 'B005',
      reasonForVisit: 'Dental cleaning',
      status: AppointmentStatus.completed,
    ),
  ];

  static List<Doctor> getDoctorsByPolyclinic(String polyclinicId) {
    return doctors.where((doctor) => doctor.polyclinicId == polyclinicId).toList();
  }

  static Doctor? getDoctorById(String doctorId) {
    try {
      return doctors.firstWhere((doctor) => doctor.id == doctorId);
    } catch (e) {
      return null;
    }
  }

  static List<String> getAvailableTimeSlots(String doctorId, String day) {
    final doctor = getDoctorById(doctorId);
    if (doctor == null) return [];    final schedule = doctor.schedules.where((s) => s.day == day).firstOrNull;
    if (schedule == null) return [];
    
    final allSlots = <String>[];
    final startHour = int.parse(schedule.startTime.split(':')[0]);
    final endHour = int.parse(schedule.endTime.split(':')[0]);

    for (var hour = startHour; hour < endHour; hour++) {
      final timeSlot = '${hour.toString().padLeft(2, '0')}:00';
      if (!schedule.bookedSlots.contains(timeSlot)) {
        allSlots.add(timeSlot);
      }
    }

    return allSlots;
  }

  static String generateQueueNumber() {
    final letters = ['A', 'B', 'C', 'D'];
    final letter = letters[DateTime.now().millisecond % letters.length];
    final number = (DateTime.now().millisecond % 999 + 1).toString().padLeft(3, '0');
    return '$letter$number';
  }

  static List<Appointment> getUserAppointments(String userId) {
    return appointments.where((apt) => apt.userId == userId).toList();
  }

  static void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }

  static void cancelAppointment(String appointmentId) {
    final index = appointments.indexWhere((apt) => apt.id == appointmentId);
    if (index != -1) {
      appointments[index] = Appointment(
        id: appointments[index].id,
        userId: appointments[index].userId,
        doctorId: appointments[index].doctorId,
        doctorName: appointments[index].doctorName,
        polyclinicName: appointments[index].polyclinicName,
        date: appointments[index].date,
        time: appointments[index].time,
        queueNumber: appointments[index].queueNumber,
        reasonForVisit: appointments[index].reasonForVisit,
        status: AppointmentStatus.cancelled,
      );
    }
  }
}
