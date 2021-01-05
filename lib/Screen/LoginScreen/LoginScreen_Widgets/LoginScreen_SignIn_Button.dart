import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenSignInButton extends StatelessWidget {
  const LoginScreenSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            style: TextStyle(
              fontSize: 24.ssp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.navigate_next,
              size: 40.h,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
