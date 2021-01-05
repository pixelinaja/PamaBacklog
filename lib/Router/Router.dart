import 'package:PamaBacklog/Logic/FCM/bloc/sendnotification_bloc.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'RouteName.dart';
import '../Screen/HomeScreen/HomeScreen.dart';
import '../Screen/LoginScreen/LoginScreen.dart';
import '../Screen/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  /// Send Notification Bloc
  final SendNotificationBloc _sendNotificationBloc =
      SendNotificationBloc(fcmRepository: FCMService());

  /// Generate Screens Router
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider.value(value: _sendNotificationBloc)],
            child: SplashScreen(),
          ),
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
  void dispose() {
    _sendNotificationBloc.close();
  }
}
