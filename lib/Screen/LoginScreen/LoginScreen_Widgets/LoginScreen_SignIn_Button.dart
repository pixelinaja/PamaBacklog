import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenSignInButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  LoginScreenSignInButton(
      {Key key, this.emailController, this.passwordController})
      : super(key: key);

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
          GestureDetector(
            onTap: () => context.read<AuthBloc>().add(
                  AuthLogin(
                      email: emailController.text + "@pixelinstudio.com",
                      password: passwordController.text),
                ),
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}
