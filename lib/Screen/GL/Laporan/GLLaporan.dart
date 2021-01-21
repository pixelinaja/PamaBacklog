import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeAppBar.dart';
import 'package:PamaBacklog/Screen/GL/Laporan/Laporan_Widgets/GLLaporanHistoryRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Laporan_Widgets/GLLaporanHistoryTable.dart';

class GLLaporan extends StatelessWidget {
  const GLLaporan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      child: GLHomeAppBar(),
                      visible: orientation == Orientation.portrait,
                    ),
                    SizedBox(height: 14.h),
                    GLLaporanHistoryRow(orientation: orientation),
                    SizedBox(height: 10.h),
                    GLLaporanHistoryTable(orientation: orientation),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
