import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenBackgroundImage extends StatelessWidget {
  const LoginScreenBackgroundImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.login_bg,
      fit: BoxFit.cover,
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
    );
  }
}
