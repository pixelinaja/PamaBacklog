import 'dart:async';

import 'package:PamaBacklog/Model/UserModel.dart';
import 'package:PamaBacklog/Service/AuthRepository.dart';
import 'package:PamaBacklog/Service/UserRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authenticationRepository;
  final UserRepository _userRepository = UserService();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  AuthBloc({AuthRepository authRepository})
      : assert(authRepository != null),
        _authenticationRepository = authRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    /// If Event is Auth User State Changed. Then Perform User Get.
    /// If Return Null, then return Auth Initial
    if (event is AuthUserStateChanged) {
      yield AuthUserLoggingIn();
      if (event.user == null) {
        yield AuthUserUnknown();
      } else {
        try {
          await _userRepository.updateUserData(userId: event.user.uid);
          UserModel user =
              await _userRepository.getUserData(userId: event.user.uid);
          _firebaseMessaging.subscribeToTopic(user.role);
          yield AuthUserLoggedIn(userData: user);
        } catch (e) {
          yield AuthUserUnknown();
        }
      }
    }

    /// If Event is Auth Login (Login Button Pressed)
    /// Perform Login Action
    else if (event is AuthLogin) {
      yield AuthUserLoggingIn();
      try {
        UserCredential user = await _authenticationRepository.login(
            email: event.email, password: event.password);

        await _userRepository.updateUserData(userId: user.user.uid);
        UserModel userData =
            await _userRepository.getUserData(userId: user.user.uid);
        _firebaseMessaging.subscribeToTopic(userData.role);
        yield AuthUserLoggedIn(userData: userData);
      } on FirebaseAuthException catch (e) {
        yield AuthUserLoginFail(errorMsg: e.message);
      } on Exception catch (e) {
        yield AuthUserLogoutFail(errorMsg: e.toString());
      }
    }

    /// If Event is Auth Logout (Logout Button Pressed)
    /// Perform Logout Action
    else if (event is AuthLogout) {
      try {
        await _authenticationRepository.logout();
        _firebaseMessaging.unsubscribeFromTopic("0");
        _firebaseMessaging.unsubscribeFromTopic("1");
        _firebaseMessaging.unsubscribeFromTopic("2");
        yield AuthUserUnknown();
      } on FirebaseAuthException catch (e) {
        yield AuthUserLogoutFail(errorMsg: e.message);
      } on Exception catch (e) {
        yield AuthUserLogoutFail(errorMsg: e.toString());
      }
    }
  }
}
