import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../services/mock_data_service.dart';
import '../widgets/page_header_widget.dart';
import '../widgets/appointment_card_widget.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadAppointments() {
    final user = MockDataService.currentUser;
    if (user != null) {
      setState(() {
        _appointments = MockDataService.getUserAppointments(user.id);
      });
    }
  }

  List<Appointment> get _upcomingAppointments {
    return _appointments
        .where((apt) => 
            apt.status == AppointmentStatus.confirmed && 
            apt.date.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  List<Appointment> get _pastAppointments {
    return _appointments
        .where((apt) => 
            apt.status == AppointmentStatus.completed || 
            apt.status == AppointmentStatus.cancelled ||
            (apt.status == AppointmentStatus.confirmed && apt.date.isBefore(DateTime.now())))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  void _cancelAppointment(String appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Appointment'),
          content: const Text('Are you sure you want to cancel this appointment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {                MockDataService.cancelAppointment(appointmentId);
                _loadAppointments();
                Navigator.of(context).pop();                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment cancelled successfully'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const PageHeaderWidget(
        title: 'My Appointments',
        showBackButton: false,
      ),
      body: Column(
        children: [          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: theme.colorScheme.onPrimary,
              unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              indicator: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Upcoming Appointments
                _upcomingAppointments.isEmpty
                    ? _buildEmptyState(
                        icon: Icons.calendar_today,
                        title: 'No Upcoming Appointments',
                        subtitle: 'Book a new appointment to see it here',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _upcomingAppointments.length,
                        itemBuilder: (context, index) {
                          final appointment = _upcomingAppointments[index];
                          return AppointmentCardWidget(
                            appointment: appointment,
                            onCancel: () => _cancelAppointment(appointment.id),
                          );
                        },
                      ),
                // Past Appointments
                _pastAppointments.isEmpty
                    ? _buildEmptyState(
                        icon: Icons.history,
                        title: 'No Past Appointments',
                        subtitle: 'Your appointment history will appear here',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _pastAppointments.length,
                        itemBuilder: (context, index) {
                          final appointment = _pastAppointments[index];
                          return AppointmentCardWidget(
                            appointment: appointment,
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(50),
              ),
              child:              Icon(
                icon,
                size: 64,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
