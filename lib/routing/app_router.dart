import 'package:flutter/material.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/initial_auth_screen.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/login/login_screen.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/signup/signup_screen.dart';
import 'package:gym_tracker/pages/home/home_screen.dart';

class AppRoutes {
  static const String initAuthScreen = '/init-auth-screen';
  static const String authLoginScreen = '/auth-login-screen';
  static const String authSignUpScreen = '/auth-signup-screen';
  static const String homeScreen = '/home-screen';
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
      default:
        return null;
    }
  }
}
