import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  LoginScreenFields({Key key, this.emailController, this.passwordController})
      : super(key: key);

  @override
  _LoginScreenFieldsState createState() => _LoginScreenFieldsState();
}

class _LoginScreenFieldsState extends State<LoginScreenFields> {
  TextEditingController get emailController => widget.emailController;
  TextEditingController get passwordController => widget.passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.w),
          child: TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.white),
            enabled: (context.watch<AuthBloc>().state is AuthUserLoggingIn)
                ? false
                : true,
            decoration: InputDecoration(
              isDense: true,
              hintStyle: TextStyle(color: Colors.white),
              hintText: "Masukkan Username",
              labelText: "Username",
              labelStyle: TextStyle(color: Colors.white),
              alignLabelWithHint: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5.w),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5.w),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.w),
          child: TextFormField(
            controller: passwordController,
            enabled: (context.watch<AuthBloc>().state is AuthUserLoggingIn)
                ? false
                : true,
            style: TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Masukkan Password",
              hintStyle: TextStyle(color: Colors.white),
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.white),
              alignLabelWithHint: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5.w),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.5.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
