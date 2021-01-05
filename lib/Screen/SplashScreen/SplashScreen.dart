import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:PamaBacklog/Global/FirestoreConstant/FCMConstant.dart';
import 'package:PamaBacklog/Logic/Connectivity/cubit/connectivity_cubit.dart';
import 'package:PamaBacklog/Logic/FCM/bloc/sendnotification_bloc.dart';
import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseMessaging
      ..subscribeToTopic(FCMConstant.TOPIC_ORDER_CREATED)
      ..subscribeToTopic(FCMConstant.TOPIC_ORDER_GL_RESPONDED)
      ..subscribeToTopic(FCMConstant.TOPIC_ORDER_ADMIN_RESPONDED).then(
          (value) => Future.delayed(Duration(seconds: 3)).then((value) =>
              Navigator.of(context)
                  .pushReplacementNamed(RouteName.loginScreen)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      body: SafeArea(
        child: Image(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          image: Svg(
            Assets.pesan_keselamatan_1,
            size: Size(700.w, ScreenUtil().screenHeight),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
