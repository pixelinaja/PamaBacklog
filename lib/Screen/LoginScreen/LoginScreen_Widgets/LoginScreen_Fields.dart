import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenFields extends StatefulWidget {
  LoginScreenFields({Key key}) : super(key: key);

  @override
  _LoginScreenFieldsState createState() => _LoginScreenFieldsState();
}

class _LoginScreenFieldsState extends State<LoginScreenFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.w),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
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
