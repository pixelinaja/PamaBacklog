import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            child: Text("Pama Backlog"),
            onTap: () => Navigator.of(context).pushNamed(RouteName.loginScreen),
          ),
        ),
      ),
    );
  }
}
