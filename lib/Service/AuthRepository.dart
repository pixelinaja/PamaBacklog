import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthRepository {
  /// Sign Up Function
  Future<UserCredential> signUp({
    @required String email,
    @required String password,
  });

  /// Login Function
  Future<UserCredential> login({
    @required String email,
    @required String password,
  });

  /// Logout Function
  Future<void> logout();
}

class AuthService implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  AuthService({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  /// Creates a new user with the provided [email] and [password].
  @override
  Future<UserCredential> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs in with the provided [email] and [password].
  @override
  Future<UserCredential> login({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the current user
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
