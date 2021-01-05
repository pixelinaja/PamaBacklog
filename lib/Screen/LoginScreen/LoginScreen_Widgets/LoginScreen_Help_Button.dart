import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenHelpButton extends StatelessWidget {
  const LoginScreenHelpButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24.w),
      alignment: Alignment.centerRight,
      child: IconButton(
          icon: Icon(
            Icons.live_help,
            size: 33.ssp,
          ),
          onPressed: () {}),
    );
  }
}
