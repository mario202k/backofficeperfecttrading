import 'package:backoffice/src/domain/admin_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/firestore_service.dart';
import '../domain/app_user.dart';
import '../domain/app_version.dart';
import '../domain/notification.dart';
import '../domain/purchase.dart';
import 'paths.dart';

final appUserRepositoryProvider =
    Provider.autoDispose<AppUserRepository>((ref) {
  return AppUserRepository();
});

abstract class AppUserRepositoryInterface {
  Future<AppUser> getAppUser({required String userId});

  Stream<int> getNumberOfAppUsers();

  Stream<int> getNumberOfPremium();

  Stream<int> getNumberOfLogged();

  Stream<int> getNumberOfOnline();

  Stream<int> getNumberOfDeletedAccount();

  Future<List<AppUser>> getPremiumAppUsers({DateTime? date});

  Future<List<AppUser>> getLoggedAppUsers({DateTime? date});

  Future<List<AppUser>> getOnlineAppUsers({DateTime? date});

  Future<List<AppUser>> getDeletedAppUsers({DateTime? date});

  Future<List<AppUser>> getAppUsers();

  Stream<List<AppUser?>> getStreamAppUsers();

  Future<void> setAppUser({required AppUser appUser});

  Future<void> setAdminUser({required AdminUser adminUser});

  Future<void> updateAppUser(
      {required MapEntry<String, dynamic> entry, required String userId});

  Stream<AppUser?> watchAppUser({required String userId});

  Future<Purchase> getPurchase(
      {required String userId, required String purchaseId});

  Future<Purchase?> getLastPurchase({required String userId});

  Future<void> setPurchase(
      {required String userId, required Purchase purchase});

  Future<Notification> getNotification(
      {required String userId, required String notificationId});

  Future<void> setNotification(
      {required String userId, required Notification notification});

  Future<List<Notification>> getNotifications({required String userId});

  Future<void> setAppVersion({required AppVersion appVersion});

  Future<AppVersion?> getLastAppVersion();
}

class AppUserRepository implements AppUserRepositoryInterface {
  final _service = FirestoreService.instance;

  @override
  Future<AppUser> getAppUser({required String userId}) {
    return _service.getDoc(
        path: Paths.appUser(userId: userId),
        builder: (data) => AppUser.fromMap(data));
  }

  @override
  Future<List<AppUser>> getAppUsers({DateTime? date}) {
    return _service.collectionFuture(
        path: Paths.appUsers(),
        queryBuilder: date != null
            ? (query) => query.where('updatedAt', isGreaterThan: date)
            : null,
        builder: (data) => AppUser.fromMap(data));
  }

  @override
  Future<Notification> getNotification(
      {required String userId, required String notificationId}) {
    return _service.getDoc(
        path:
            Paths.notification(userId: userId, notificationId: notificationId),
        builder: (data) => Notification.fromMap(data));
  }

  @override
  Future<List<Notification>> getNotifications({required String userId}) {
    return _service.collectionFuture(
        path: Paths.notifications(userId: userId),
        builder: (data) => Notification.fromMap(data));
  }

  @override
  Future<Purchase> getPurchase(
      {required String userId, required String purchaseId}) {
    return _service.getDoc(
        path: Paths.purchase(userId: userId, purchaseId: purchaseId),
        builder: (data) => Purchase.fromMap(data));
  }

  @override
  Future<void> setAppUser({required AppUser appUser}) {
    return _service.setDataWithAwait(
        path: Paths.appUser(userId: appUser.id), data: appUser.toMap());
  }

  @override
  Future<void> setNotification(
      {required String userId, required Notification notification}) {
    return _service.setDataWithAwait(
        path:
            Paths.notification(userId: userId, notificationId: notification.id),
        data: notification.toMap());
  }

  @override
  Future<void> setPurchase(
      {required String userId, required Purchase purchase}) {
    return _service.setDataWithAwait(
      path: Paths.purchase(userId: userId, purchaseId: purchase.id),
      data: purchase.toMap(),
    );
  }

  @override
  Stream<AppUser?> watchAppUser({required String userId}) {
    return _service.documentStream(
        path: Paths.appUser(userId: userId),
        builder: (data) => data != null ? AppUser.fromMap(data) : null);
  }

  @override
  Future<void> updateAppUser(
      {required MapEntry<String, dynamic> entry, required String userId}) {
    return _service.updateData(
        path: Paths.appUser(userId: userId), data: entry);
  }

  @override
  Future<Purchase?> getLastPurchase({required String userId}) async {
    final listPurchase = await _service.collectionFuture(
        path: Paths.purchases(userId: userId),
        queryBuilder: (query) =>
            query.orderBy('createdAt', descending: true).limit(1),
        builder: (data) => Purchase.fromMap(data));
    return listPurchase.isNotEmpty ? listPurchase.first : null;
  }

  @override
  Future<void> setAdminUser({required AdminUser adminUser}) {
    return _service.setDataWithAwait(
        path: Paths.adminUser(userId: adminUser.id), data: adminUser.toMap());
  }

  @override
  Stream<int> getNumberOfAppUsers() {
    return _service.getCollectionCountStream(path: Paths.appUsers());
  }

  @override
  Stream<int> getNumberOfDeletedAccount() {
    return _service.getCollectionCountStream(
        path: Paths.appUsers(),
        queryBuilder: (query) =>
            query.where('hasDeletedAccount', isEqualTo: true));
  }

  @override
  Stream<int> getNumberOfLogged() {
    return _service.getCollectionCountStream(
        path: Paths.appUsers(),
        queryBuilder: (query) => query.where('isLogged', isEqualTo: true));
  }

  @override
  Stream<int> getNumberOfOnline() {
    return _service.getCollectionCountStream(
        path: Paths.appUsers(),
        queryBuilder: (query) => query.where('isOnline', isEqualTo: true));
  }

  @override
  Stream<int> getNumberOfPremium() {
    return _service.getCollectionCountStream(
        path: Paths.appUsers(),
        queryBuilder: (query) => query.where('isPremium', isEqualTo: true));
  }

  @override
  Future<List<AppUser>> getDeletedAppUsers({DateTime? date}) {
    return _service.collectionFuture(
        path: Paths.appUsers(),
        queryBuilder: (query) => query
            .where('hasDeletedAccount', isEqualTo: true)
            .where("updatedAt", isGreaterThan: date)
            .orderBy("updatedAt", descending: true),
        builder: (data) => AppUser.fromMap(data));
  }

  @override
  Future<List<AppUser>> getLoggedAppUsers({DateTime? date}) {
    return _service.collectionFuture(
        path: Paths.appUsers(),
        queryBuilder: (query) => query
            .where('isLogged', isEqualTo: true)
            .where("updatedAt", isGreaterThan: date)
            .orderBy("updatedAt", descending: true),
        builder: (data) => AppUser.fromMap(data));
  }

  @override
  Future<List<AppUser>> getOnlineAppUsers({DateTime? date}) {
    return _service.collectionFuture(
        path: Paths.appUsers(),
        queryBuilder: (query) => query
            .where('isOnline', isEqualTo: true)
            .where("updatedAt", isGreaterThan: date)
            .orderBy("updatedAt", descending: true),
        builder: (data) => AppUser.fromMap(data));
  }

  @override
  Future<List<AppUser>> getPremiumAppUsers({DateTime? date}) {
    return _service.collectionFuture(
        path: Paths.appUsers(),
        queryBuilder: (query) => query
            .where('isPremium', isEqualTo: true)
            .where("updatedAt", isGreaterThan: date)
            .orderBy("updatedAt", descending: true),
        builder: (data) => AppUser.fromMap(data));
  }

  @override
  Stream<List<AppUser?>> getStreamAppUsers() {
    return _service.collectionStream(
        path: Paths.appUsers(),
        builder: (data) => data != null ? AppUser.fromMap(data) : null);
  }


  @override
  Future<AppVersion?> getLastAppVersion() async {
    final rep = await _service.collectionFuture(
        path: Paths.appVersions(),
        queryBuilder: (query) => query.orderBy('createdAt', descending: true),
        builder: (data) => AppVersion.fromMap(data));
    return rep.isNotEmpty ? rep.first : null;
  }

  @override
  Future<void> setAppVersion({required AppVersion appVersion}) {
    return _service.setDataWithAwait(
        path: Paths.appVersion(version: appVersion.version),
        data: appVersion.toMap());
  }
}
