import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminStatistik_widgets/AdminHomeStatistikTotal.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeStatistik_widgets/GLHomeStatistikGraphImage.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeStatistik_widgets/GLHomeStatistikTotal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeStatistik extends StatelessWidget {
  const AdminHomeStatistik({Key key}) : super(key: key);

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
          AdminHomeStatistikTotal(),
          Spacer(),
          Divider(
            color: Colors.black,
            indent: 40.w,
            endIndent: 40.w,
          ),
        ],
      ),
    );
  }
}
