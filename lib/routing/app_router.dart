import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/main_navigation_screen.dart';
import '../screens/find_doctor_screen.dart';
import '../screens/doctor_profile_screen.dart';
import '../screens/polyclinic_doctors_screen.dart';
import '../screens/book_appointment_screen.dart';
import '../screens/my_appointments_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/booking_success_screen.dart';
import '../models/doctor.dart';
import '../models/polyclinic.dart';
import '../models/appointment.dart';

/// Optimized route generator with performance improvements
class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String mainNavigation = '/main';
  static const String findDoctor = '/find-doctor';
  static const String doctorProfile = '/doctor-profile';
  static const String polyclinicDoctors = '/polyclinic-doctors';
  static const String bookAppointment = '/book-appointment';
  static const String myAppointments = '/my-appointments';
  static const String profile = '/profile';
  static const String bookingSuccess = '/booking-success';

  /// Generate routes with optimized transitions
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case splash:
        page = const SplashScreen();
        break;
      
      case login:
        page = const LoginScreen();
        break;
      
      case register:
        page = const RegisterScreen();
        break;
      
      case home:
        page = const HomeScreen();
        break;
      
      case mainNavigation:
        page = const MainNavigationScreen();
        break;
      
      case findDoctor:
        page = const FindDoctorScreen();
        break;      case doctorProfile:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && 
            args['doctor'] is Doctor &&
            args['polyclinic'] is Polyclinic) {
          page = DoctorProfileScreen(
            doctor: args['doctor'] as Doctor,
            polyclinic: args['polyclinic'] as Polyclinic,
          );
        } else {
          return _createErrorRoute('Doctor and polyclinic required');
        }
        break;
      
      case polyclinicDoctors:
        final polyclinic = settings.arguments as Polyclinic?;
        if (polyclinic != null) {
          page = PolyclinicDoctorsScreen(polyclinic: polyclinic);
        } else {
          return _createErrorRoute('Polyclinic not provided');
        }
        break;
        case bookAppointment:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && 
            args['doctor'] is Doctor &&
            args['polyclinic'] is Polyclinic &&
            args['selectedDay'] is String &&
            args['selectedTime'] is String) {
          page = BookAppointmentScreen(
            doctor: args['doctor'] as Doctor,
            polyclinic: args['polyclinic'] as Polyclinic,
            selectedDay: args['selectedDay'] as String,
            selectedTime: args['selectedTime'] as String,
          );
        } else {
          return _createErrorRoute('Invalid booking arguments provided');
        }
        break;
      
      case myAppointments:
        page = const MyAppointmentsScreen();
        break;
      
      case profile:
        page = const ProfileScreen();
        break;
        case bookingSuccess:
        final appointment = settings.arguments as Appointment?;
        if (appointment != null) {
          page = BookingSuccessScreen(appointment: appointment);
        } else {
          return _createErrorRoute('Appointment not provided');
        }
        break;
      
      default:
        return _createErrorRoute(settings.name);
    }

    return _createOptimizedRoute(page, settings);
  }

  /// Create optimized route with smooth transition
  static PageRoute<T> _createOptimizedRoute<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 150),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Use different transitions based on route
        if (settings.name == splash || settings.name == login) {
          return FadeTransition(opacity: animation, child: child);
        }

        // Default slide transition
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
  /// Create error route
  static Route<dynamic> _createErrorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Route not found: ${routeName ?? 'Unknown'}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(splash),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Push with custom transition
  static Future<T?> pushWithTransition<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    RouteTransition transition = RouteTransition.slide,
  }) {
    return Navigator.of(context).push<T>(
      _createCustomTransitionRoute<T>(
        routeName,
        arguments: arguments,
        transition: transition,
      ),
    );
  }

  /// Create custom transition route
  static PageRoute<T> _createCustomTransitionRoute<T>(
    String routeName, {
    Object? arguments,
    RouteTransition transition = RouteTransition.slide,
  }) {
    final settings = RouteSettings(name: routeName, arguments: arguments);
    final route = generateRoute(settings);
    
    if (route is PageRouteBuilder<T>) {
      return route;
    }
    
    // Fallback to material route
    return route as PageRoute<T>;
  }
}

/// Available route transitions
enum RouteTransition {
  slide,
  fade,
  scale,
  slideUp,
}

/// Route transition builders
class RouteTransitions {
  RouteTransitions._();

  static Widget slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOutCubic;

    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget scaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      )),
      child: child,
    );
  }
}
