import 'dart:async';

import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  StreamSubscription<User> user;

  Random rnd = new Random();
  var arraySplash = [
    Assets.pesan_keselamatan_1,
    Assets.pesan_keselamatan_2,
    Assets.pesan_keselamatan_3,
    Assets.pesan_keselamatan_4
  ];

  @override
  void initState() {
    super.initState();
    // var element = arraySplash[rnd.nextInt(arraySplash.length)];

    /// Refresh the Screen after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      user = FirebaseAuth.instance.authStateChanges().listen((event) {
        return context.read<AuthBloc>().add(AuthUserStateChanged(user: event));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        /// Navigate the user based on Bloc's State
        if (state is AuthUserLoggedIn) {
          Future.delayed(Duration(seconds: 5)).then((value) =>
              Navigator.of(context).pushReplacementNamed(RouteName.homeScreen));
        } else if (state is AuthUserUnknown) {
          Future.delayed(Duration(seconds: 5)).then((value) =>
              Navigator.of(context)
                  .pushReplacementNamed(RouteName.loginScreen));
        }
      },
      child: Scaffold(
        key: _scaffoldstate,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SafeArea(
              child: Image.asset(
                arraySplash[rnd.nextInt(arraySplash.length)],
                fit: BoxFit.fill,
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    user?.cancel();
    super.dispose();
  }
}
