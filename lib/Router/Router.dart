import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTableSwitch/cubit/mekaniktableswitch_cubit.dart';
import 'package:PamaBacklog/Logic/Mekanik/SaveBacklog/cubit/MekanikSaveBacklog_cubit.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Screen/Admin/AddCN/AdminAddCN.dart';
import 'package:PamaBacklog/Screen/Admin/DataCN/AdminDataCN.dart';
import 'package:PamaBacklog/Screen/Admin/DetailLaporanTerbuka/AdminDetailLaporanTerbuka.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LaporanTerbuka/AdminLaporanTerbuka.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LogLaporan/AdminLogLaporan.dart';
import 'package:PamaBacklog/Screen/GL/DetailLaporan/GLDetailLaporan.dart';
import 'package:PamaBacklog/Screen/GL/Laporan/GLLaporan.dart';
import 'package:PamaBacklog/Screen/GL/ListDetail/GLListDetail.dart';
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
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case RouteName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MekanikTableSwitchCubit()),
            ],
            child: const HomeScreen(),
          ),
          settings: settings,
        );
      case RouteName.mekanikAddBacklog:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => MekanikSaveBacklogCubit()),
            ],
            child: const MekanikAddBacklog(),
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
          builder: (_) => const GLLaporan(),
          settings: settings,
        );
      case RouteName.glDetailLaporan:
        return MaterialPageRoute(
          builder: (_) => const GLDetailLaporan(),
          settings: settings,
        );
      case RouteName.glListDetail:
        return MaterialPageRoute(
          builder: (_) => const GLListDetail(),
          settings: settings,
        );
      case RouteName.glPerluPersetujuan:
        return MaterialPageRoute(
          builder: (_) => const GLPerluPersetujuan(),
          settings: settings,
        );
      case RouteName.adminLogLaporan:
        return MaterialPageRoute(
          builder: (_) => const AdminLogLaporan(),
          settings: settings,
        );
      case RouteName.adminLaporanTerbuka:
        return MaterialPageRoute(
          builder: (_) => const AdminLaporanTerbuka(),
          settings: settings,
        );
      case RouteName.adminDetailLaporanTerbuka:
        return MaterialPageRoute(
          builder: (_) => const AdminDetailLaporanTerbuka(),
          settings: settings,
        );
      case RouteName.adminDataCN:
        return MaterialPageRoute(
          builder: (_) => const AdminDataCN(),
          settings: settings,
        );
      case RouteName.adminAddCN:
        return MaterialPageRoute(
          builder: (_) => const AdminAddCN(isAdd: true),
          settings: settings,
        );
      case RouteName.adminEditCN:
        return MaterialPageRoute(
          builder: (_) => const AdminAddCN(isAdd: false),
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
