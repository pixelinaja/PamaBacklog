part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({@required this.email, @required this.password});

  @override
  List<Object> get props => [this.email, this.password];
}

class AuthUserStateChanged extends AuthEvent {
  final User user;

  AuthUserStateChanged({this.user});

  @override
  List<Object> get props => [user];
}

class AuthLogout extends AuthEvent {}
