import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/app_user_repository.dart';
import '../domain/app_user.dart';
import '../domain/purchase.dart';
import 'auth_service.dart';

final appUserServiceProvider = Provider.autoDispose<AppUserService>((ref) {
  return AppUserService(
      appUserRepository: ref.watch(appUserRepositoryProvider),
      authService: ref.watch(authServiceProvider));
});

abstract class AppUserServiceInterface {
  Future<AppUser> getAppUser({required String userId});


  Stream<int> getNumberOfAppUsers();
  Stream<int> getNumberOfPremium();
  Stream<int> getNumberOfLogged();
  Stream<int> getNumberOfOnline();
  Stream<int> getNumberOfDeletedAccount();

  Future<void> updateAppUser(
      {required MapEntry<String, dynamic> entry, required String userId});

  Stream<AppUser?> watchAppUser();

  Future<void> setAppUser({required AppUser appUser});

  Future<void> setPurchase(
      {required String userId, required Purchase purchase});

  Future<Purchase> getPurchase(
      {required String userId, required String purchaseId});
}

class AppUserService implements AppUserServiceInterface {
  final AuthService authService;
  final AppUserRepository appUserRepository;

  AppUserService({required this.authService, required this.appUserRepository});

  @override
  Future<AppUser> getAppUser({required String userId}) {
    return appUserRepository.getAppUser(userId: userId);
  }

  @override
  Future<Purchase> getPurchase(
      {required String userId, required String purchaseId}) {
    return appUserRepository.getPurchase(
        userId: userId, purchaseId: purchaseId);
  }

  @override
  Future<void> setAppUser({required AppUser appUser}) {
    return appUserRepository.setAppUser(appUser: appUser);
  }

  @override
  Future<void> setPurchase(
      {required String userId, required Purchase purchase}) {
    return appUserRepository.setPurchase(userId: userId, purchase: purchase);
  }

  @override
  Future<void> updateAppUser(
      {required MapEntry<String, dynamic> entry, required String userId}) {
    return appUserRepository.updateAppUser(entry: entry, userId: userId);
  }

  @override
  Stream<AppUser?> watchAppUser() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty();
    }
    return appUserRepository.watchAppUser(userId: userId);
  }

  @override
  Stream<int> getNumberOfAppUsers() {
    return appUserRepository.getNumberOfAppUsers();
  }

  @override
  Stream<int> getNumberOfDeletedAccount() {
    return appUserRepository.getNumberOfDeletedAccount();
  }

  @override
  Stream<int> getNumberOfLogged() {
    return appUserRepository.getNumberOfLogged();
  }

  @override
  Stream<int> getNumberOfOnline() {
    return appUserRepository.getNumberOfOnline();
  }

  @override
  Stream<int> getNumberOfPremium() {
    return appUserRepository.getNumberOfPremium();
  }
}
