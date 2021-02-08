import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminLaporanTerbukaTableContainer extends StatelessWidget {
  final List<Widget> widgets;
  const AdminLaporanTerbukaTableContainer({Key key, @required this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 695.h,
      decoration: BoxDecoration(
        color: ThemeData().scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
        ),
      ),
      child: Column(
        children: widgets,
      ),
    );
  }
}
