import 'package:flutter/material.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/initial_auth_screen.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/login/login_screen.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/signup/signup_screen.dart';
import 'package:gym_tracker/pages/home/home_screen.dart';
import 'package:gym_tracker/pages/messaging_contacts/messaging_contacts_screen.dart';

class AppRoutes {
  static const String initAuthScreen = '/init-auth-screen';
  static const String authLoginScreen = '/auth-login-screen';
  static const String authSignUpScreen = '/auth-signup-screen';
  static const String homeScreen = '/home-screen';
  static const String messagingContactsScreen = '/messaging-contacts-screen';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.initAuthScreen:
        return MaterialPageRoute(
            builder: (_) => InitialAuthScreen(), settings: settings);
      case AppRoutes.authLoginScreen:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      case AppRoutes.authSignUpScreen:
        return MaterialPageRoute(
            builder: (_) => SignUpScreen(), settings: settings);
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case AppRoutes.messagingContactsScreen:
        return MaterialPageRoute(
            builder: (_) => MessagingContactsScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => _errorScreen());
    }
  }

  static Widget _errorScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Error',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text("Something went wrong. This is an error page."),
      ),
    );
  }
}
