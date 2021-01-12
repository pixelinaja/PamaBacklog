import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:PamaBacklog/Screen/Admin/Home/AdminHome.dart';
import 'package:PamaBacklog/Screen/GL/Home/GLHome.dart';
import 'package:PamaBacklog/Screen/Mekanik/Home/MekanikHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUserLoggedIn) {
            switch (state.userData.role) {
              case "0":
                return AdminHome();
                break;
              case "1":
                return GLHome();
                break;
              case "2":
                return MekanikHome();
                break;
              default:
                return Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () => context.read<AuthBloc>().add(AuthLogout()),
                      child: Text("Error, Tap Here to Log out"),
                    ),
                  ),
                );
            }
          } else {
            return Container(
              child: Center(
                child: GestureDetector(
                  onTap: () => context.read<AuthBloc>().add(AuthLogout()),
                  child: Text("Error, Tap Here to Log out"),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
