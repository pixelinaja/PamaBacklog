import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeAppBar.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeStatistik.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLHome extends StatelessWidget {
  const GLHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GLHomeAppBar(),
              SizedBox(
                height: 14.h,
              ),
              GLHomeStatistik(),
            ],
          ),
        ),
      ),
    );
  }
}
