part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial
class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

/// User Unknown
class AuthUserUnknown extends AuthState {
  @override
  List<Object> get props => [];
}

/// User Logging In (Loading)
class AuthUserLoggingIn extends AuthState {
  @override
  List<Object> get props => [];
}

/// User Logged In Successfully
class AuthUserLoggedIn extends AuthState {
  final UserModel userData;

  AuthUserLoggedIn({this.userData});

  @override
  List<Object> get props => [userData];
}

/// User Login Failed
class AuthUserLoginFail extends AuthState {
  final String errorMsg;

  AuthUserLoginFail({this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

/// User Logout Failed
class AuthUserLogoutFail extends AuthState {
  final String errorMsg;

  AuthUserLogoutFail({this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
