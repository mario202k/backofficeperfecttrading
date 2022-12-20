import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/app_exception.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepository();
});

abstract class AuthRepositoryInterface {
  Future<void> changePassword();

  Future<void> deleteAccount();

  Future<void> signOut();

  Future<void> resetPasswordEmail({required String email});

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<bool> emailExist({required String email});

  User? getCurrentUser();

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password});
}

class AuthRepository implements AuthRepositoryInterface {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> changePassword() {

    return _firebaseAuth
        .sendPasswordResetEmail(email: _firebaseAuth.currentUser!.email!)
        .catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  @override
  Future<void> deleteAccount() {
    return _firebaseAuth.currentUser!.delete().catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  @override
  Future<bool> emailExist({required String email}) async {
    final list = await _firebaseAuth
        .fetchSignInMethodsForEmail(email)
        .catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
    if (list.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> resetPasswordEmail({required String email}) {
    return _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut().catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  void _authExceptionToReadableError(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        throw const AppException.invalidEmail();
      case "wrong-password":
        throw const AppException.wrongPassword();
      case "weak-password":
        throw const AppException.weakPassword();
      case "email-already-in-use":
        throw const AppException.emailAlreadyInUse();
      case "user-not-found":
        throw const AppException.userNotFound();
      case "user-disabled":
        throw const AppException.userDisabled();
      case "too-many-requests":
        throw const AppException.tooManyRequests();
      case "operation-not-allowed":
        throw const AppException.operationNotAllowed();
      case "email-already-exists":
        throw const AppException.emailAlreadyExists();
      case "network-request-failed":
        throw const AppException.networkRequestFailed();
      default:
        throw AppException.unknown(e.toString());
    }
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((onError) {
      if (onError is FirebaseAuthException) {
        _authExceptionToReadableError(onError);
      } else if (onError is SocketException) {
        throw const AppException.noInternet();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }
}
