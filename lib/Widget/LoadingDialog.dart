import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: ScreenUtil().setHeight(100),
        width: ScreenUtil().setWidth(100),
        padding: EdgeInsets.all(ScreenUtil().setWidth(28)),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
