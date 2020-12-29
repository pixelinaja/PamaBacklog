import 'package:PamaBacklog/Global/FirestoreConstant/FCMConstant.dart';
import 'package:PamaBacklog/Logic/Connectivity/cubit/connectivity_cubit.dart';
import 'package:PamaBacklog/Logic/FCM/bloc/sendnotification_bloc.dart';
import 'package:PamaBacklog/Model/NotificationMsgModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ..subscribeToTopic(FCMConstant.TOPIC_ORDER_ADMIN_RESPONDED);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      body: BlocListener<SendNotificationBloc, SendNotificationState>(
        listener: (context, state) {
          if (state is SendNotificationLoading) {
            _scaffoldstate.currentState.removeCurrentSnackBar();
            _scaffoldstate.currentState.showSnackBar(
              SnackBar(
                content: Text("Sending Notification"),
              ),
            );
          } else if (state is SendNotificationSuccess) {
            _scaffoldstate.currentState.removeCurrentSnackBar();
            _scaffoldstate.currentState.showSnackBar(
              SnackBar(
                content: Text("Notification Sent"),
              ),
            );
          } else if (state is SendNotificationFailed) {
            _scaffoldstate.currentState.removeCurrentSnackBar();
            _scaffoldstate.currentState.showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: Container(
          child: Center(
            child: GestureDetector(
              child: Text("Pama Backlog"),
              onTap: () {
                final internetState = context.read<ConnectivityCubit>().state;
                if (internetState is InternetConnected) {
                  context.read<SendNotificationBloc>().add(
                        SendNotification(
                          notificationTopic: FCMConstant.TOPIC_ORDER_CREATED,
                          notificationMsg: NotificationMsgModel(
                              body: "Order xxx-xxx telah dibuat oleh xxxx",
                              orderId: "1xlslkdiwokdf",
                              orderStatus: "open",
                              title: "Order baru"),
                        ),
                      );
                } else {
                  _scaffoldstate.currentState.showSnackBar(
                    SnackBar(
                      content: Text("No Internet Connection"),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
