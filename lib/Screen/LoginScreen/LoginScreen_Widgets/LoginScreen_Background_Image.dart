import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LoginScreenBackgroundImage extends StatelessWidget {
  const LoginScreenBackgroundImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      image: Svg(
        Assets.login_bg,
        size: Size(728.w, 1288.h),
      ),
      fit: BoxFit.cover,
    );
  }
}
