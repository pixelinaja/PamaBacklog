import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenLogo extends StatelessWidget {
  const LoginScreenLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.login_logo,
      height: 50.h,
      width: 180.w,
      filterQuality: FilterQuality.high,
    );
  }
}
