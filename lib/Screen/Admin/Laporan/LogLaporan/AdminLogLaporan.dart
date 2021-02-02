import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeAppBar.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LaporanTerbuka/LaporanTerbuka_Wdigets/AdminLaporanTerbukaRow.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LaporanTerbuka/LaporanTerbuka_Wdigets/AdminLaporanTerbukaTableContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
