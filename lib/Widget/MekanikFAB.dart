import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MekanikFAB extends StatelessWidget {
  const MekanikFAB({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.w),
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.0,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: AppColor.mainFABColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Container(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          backgroundColor: Colors.red,
          onTap: () async => await Navigator.of(context)
              .pushNamed(RouteName.mekanikAddBacklog),
        ),
        SpeedDialChild(
          child: Icon(
            Icons.logout,
            color: Colors.white,
            size: 20.w,
          ),
          backgroundColor: Colors.green,
          onTap: () async {
            context.read<AuthBloc>().add(AuthLogout());
            await Navigator.of(context)
                .pushReplacementNamed(RouteName.loginScreen);
          },
        ),
      ],
    );
  }
}
