import 'package:backoffice/src/domain/admin_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../data/app_user_repository.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
import '../exceptions/app_exception.dart';

final authServiceProvider = Provider.autoDispose<AuthService>((ref) {
  return AuthService(
      authRepository: ref.read(authRepositoryProvider),
      appUserRepository: ref.read(appUserRepositoryProvider));
});

abstract class AuthServiceInterface {
  Future<Result<void, AppException>> changePassword();

  Future<Result<void, AppException>> deleteAccount();

  Future<Result<void, AppException>> signOut();

  Future<Result<void, AppException>> resetPasswordEmail(
      {required String email});

  Future<Result<void, AppException>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Result<void, AppException>> register({
    required AppUser appUser,
  });

  String? getUid();

  Future<Result<void, AppException>> createAdminUser({
    required String email,
    required String password,
  });
}

class AuthService implements AuthServiceInterface {
  final AuthRepository authRepository;
  final AppUserRepository appUserRepository;

  AuthService({
    required this.authRepository,
    required this.appUserRepository,
  });

  @override
  Future<Result<void, AppException>> changePassword() async {
    try {
      return Success(await authRepository.changePassword());
    } on AppException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<void, AppException>> deleteAccount() async {
    try {
      final userId = getUid();
      if (userId == null) {
        throw const AppException.unknown("User id is null");
      }

      final appUser = await appUserRepository.getAppUser(userId: userId);

      appUserRepository.setAppUser(
          appUser: appUser.copyWith(
        isLogged: false,
        isOnline: false,
        hasDeletedAccount: true,
        updatedAt: DateTime.now(),
      ));

      return Success(await authRepository.deleteAccount());
    } on AppException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<void, AppException>> signOut() async {
    try {
      await authRepository.signOut();

      return const Success(null);
    } on AppException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<void, AppException>> resetPasswordEmail(
      {required String email}) async {
    try {
      return Success(await authRepository.resetPasswordEmail(email: email));
    } on AppException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<void, AppException>> register(
      {required AppUser appUser}) async {
    try {
      final userCredential =
          await authRepository.createUserWithEmailAndPassword(
              email: appUser.email, password: appUser.password);

      await appUserRepository.setAppUser(
          appUser: appUser.copyWith(
        id: userCredential.user!.uid,
      ));

      return const Success(null);
    } on AppException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<void, AppException>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await authRepository.signInWithEmailAndPassword(
          email: email, password: password);

      return const Success(null);
    } on AppException catch (e) {
      return Error(e);
    }
  }

  @override
  String? getUid() {
    final user = authRepository.getCurrentUser();

    return user?.uid;
  }

  @override
  Future<Result<void, AppException>> createAdminUser(
      {required String email, required String password}) async {
    try {
      final userCredential = await authRepository
          .createUserWithEmailAndPassword(email: email, password: password);

      await appUserRepository.setAdminUser(
          adminUser: AdminUser(
              id: userCredential.user!.uid,
              email: email,
              password: password,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()));


      return const Success(null);
    } on AppException catch (e) {
      return Error(e);
    }
  }
}
