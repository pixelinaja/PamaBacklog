import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeAppBar.dart';
import 'package:PamaBacklog/Screen/GL/PerluPersetujuan/PerluPersetujuan_widgets/GLPerluPersetujuanTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'PerluPersetujuan_widgets/GLPerluPersetujuanRow.dart';

class GLPerluPersetujuan extends StatelessWidget {
  const GLPerluPersetujuan({Key key}) : super(key: key);

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
                    GLPerluPersetujuanRow(orientation: orientation),
                    SizedBox(height: 10.h),
                    GLPerluPersetujuanTable(orientation: orientation),
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
