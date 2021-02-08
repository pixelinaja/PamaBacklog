import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeAppBar.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LogLaporan/LogLaporan_Widgets/AdminLogLaporanRow.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LogLaporan/LogLaporan_Widgets/AdminLogLaporanTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'LogLaporan_Widgets/AdminLogLaporanTableContainer.dart';

class AdminLogLaporan extends StatelessWidget {
  const AdminLogLaporan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            color: AppColor.adminColor,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  AdminHomeAppBar(),
                  AdminLogLaporanTableContainer(
                    widgets: [
                      SizedBox(height: 14.h),
                      AdminLogLaporanRow(orientation: orientation),
                      SizedBox(height: 14.h),
                      AdminLogLaporanTable(orientation: orientation)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
