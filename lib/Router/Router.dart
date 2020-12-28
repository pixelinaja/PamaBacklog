import 'RouteName.dart';
import '../Screen/HomeScreen/HomeScreen.dart';
import '../Screen/LoginScreen/LoginScreen.dart';
import '../Screen/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  /// Generate Screens Router
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case RouteName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  /// Add BLoC Stream Close Here
  void dispose() {}
}
