import 'package:PamaBacklog/Logic/FCM/bloc/sendnotification_bloc.dart';
import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTableSwitch/cubit/listviewswitch_cubit.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/MekanikAddBacklog.dart';
import 'package:PamaBacklog/Service/FCMRepository.dart';
import 'package:PamaBacklog/Service/OrderRepository.dart';
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

  /// Mekanik Table Switch Cubit
  final MekanikTableSwitchCubit _mekanikTableSwitchCubit =
      MekanikTableSwitchCubit();

  /// Mekanik Table Bloc
  final MekanikTableBloc _mekanikTableBloc = MekanikTableBloc(
    orderRepository: OrderService(),
  );

  /// Generate Screens Router
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _sendNotificationBloc),
            ],
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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _mekanikTableSwitchCubit),
              BlocProvider.value(value: _mekanikTableBloc),
            ],
            child: HomeScreen(),
          ),
          settings: settings,
        );
      case RouteName.mekanikAddBacklog:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _mekanikTableBloc),
            ],
            child: MekanikAddBacklog(),
          ),
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
    _mekanikTableSwitchCubit.close();
    _mekanikTableBloc.close();
  }
}
