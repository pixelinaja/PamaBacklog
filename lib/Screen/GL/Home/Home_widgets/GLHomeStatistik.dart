import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeStatistik_widgets/GLHomeStatistikGraphImage.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeStatistik_widgets/GLHomeStatistikTotal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLHomeStatistik extends StatelessWidget {
  const GLHomeStatistik({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          GLHomeStatistikGraphImage(),
          SizedBox(height: 8.h),
          GLHomeStatistikTotal(),
          Spacer(),
          Divider(
            color: Colors.black,
            indent: 50.w,
            endIndent: 50.w,
          ),
        ],
      ),
    );
  }
}
