import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLHomeStatistikGraphImage extends StatelessWidget {
  const GLHomeStatistikGraphImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 75.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Image.asset(
        Assets.graph_icon,
      ),
    );
  }
}
