import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'LoginScreen_Widgets/LoginScreen_Background_Image.dart';
import 'LoginScreen_Widgets/LoginScreen_Logo.dart';
import 'LoginScreen_Widgets/LoginScreen_Fields.dart';
import 'LoginScreen_Widgets/LoginScreen_SignIn_Button.dart';
import 'LoginScreen_Widgets/LoginScreen_Help_Button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Lock Device orientation to vertical only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Scaffold
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            /// Login Screen's Background
            LoginScreenBackgroundImage(),

            /// Login Screen's Logo
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 24.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: LoginScreenLogo(),
              ),
            ),

            /// Login Screen's Main Widgets
            SingleChildScrollView(
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthUserLoggedIn) {
                    Navigator.of(context)
                        .pushReplacementNamed(RouteName.homeScreen);
                  } else if (state is AuthUserLoginFail) {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  } else if (state is AuthUserLoggingIn) {
                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Mohon Tunggu"),
                      duration: Duration(hours: 1),
                    ));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),

                    /// Login Screen's Help Button
                    LoginScreenHelpButton(),
                    SizedBox(
                      height: 200.h,
                    ),

                    /// Login Screen TextFields
                    LoginScreenFields(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    /// Login Screen Sign In Button
                    LoginScreenSignInButton(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
