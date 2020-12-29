import 'package:PamaBacklog/Logic/Connectivity/cubit/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              final internetState = context.read<ConnectivityCubit>().state;
              if (internetState is InternetConnected) {
                print("Internet Connected");
              } else if (internetState is InternetDisconnected) {
                print("Internet Disconnected");
              }
            },
            child: Text("Login Screen"),
          ),
        ),
      ),
    );
  }
}
