import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTableSwitch/cubit/mekaniktableswitch_cubit.dart';
import 'package:PamaBacklog/Logic/Mekanik/SaveBacklog/cubit/MekanikSaveBacklog_cubit.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Screen/Admin/DataCN/AdminDataCN.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LaporanTerbuka/AdminLaporanTerbuka.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LogLaporan/AdminLogLaporan.dart';
import 'package:PamaBacklog/Screen/GL/Laporan/GLLaporan.dart';
import 'package:PamaBacklog/Screen/GL/PerluPersetujuan/GLPerluPersetujuan.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/MekanikAddBacklog.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/MekanikDetailLaporan.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MekanikTableSwitchCubit()),
            ],
            child: HomeScreen(),
          ),
          settings: settings,
        );
      case RouteName.mekanikAddBacklog:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MekanikSaveBacklogCubit()),
            ],
            child: MekanikAddBacklog(),
          ),
          settings: settings,
        );
      case RouteName.mekanikDetailLaporan:
        TableOrderModel orderData = settings.arguments as TableOrderModel;
        return MaterialPageRoute(
          builder: (_) => MekanikDetailLaporan(orderDetail: orderData),
          settings: settings,
        );
      case RouteName.glLogLaporan:
        return MaterialPageRoute(
          builder: (_) => GLLaporan(),
          settings: settings,
        );
      case RouteName.glPerluPersetujuan:
        return MaterialPageRoute(
          builder: (_) => GLPerluPersetujuan(),
          settings: settings,
        );
      case RouteName.adminLogLaporan:
        return MaterialPageRoute(
          builder: (_) => AdminLogLaporan(),
          settings: settings,
        );
      case RouteName.adminLaporanTerbuka:
        return MaterialPageRoute(
          builder: (_) => AdminLaporanTerbuka(),
          settings: settings,
        );
      case RouteName.adminDataCN:
        return MaterialPageRoute(
          builder: (_) => AdminDataCN(),
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
}
