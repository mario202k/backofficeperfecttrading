class Paths {
  //---------------- AppUser ----------------
  static String appUser({required String userId}) => 'appUser/$userId';

  static String appUsers() => 'appUser';

  static String purchase(
          {required String userId, required String purchaseId}) =>
      'appUser/$userId/purchase/$purchaseId';

  static String purchases({required String userId}) =>
      'appUser/$userId/purchase';

  static String notification(
          {required String userId, required String notificationId}) =>
      'appUser/$userId/notification/$notificationId';

  static String notifications({required String userId}) =>
      'appUser/$userId/notification';

//---------------- AppUser ----------------
//---------------- Signal ----------------
  static String signal({required String signalId}) => 'signal/$signalId';

  static String signals() => 'signal';

//---------------- Signal ----------------
//---------------- Graph ----------------
  static graph({required String graphId}) => 'graph/$graphId';

  static graphs() => 'graph';

//---------------- Graph ----------------
// ---------------- Point ----------------
  static point({required String graphId, required String pointId}) =>
      'graph/$graphId/point/$pointId';

  static points({required String graphId}) => 'graph/$graphId/point';

//---------------- Point ----------------
//---------------- AdminUser ----------------
  static adminUsers() => 'adminUser';

  static adminUser({required String userId}) => 'adminUser/$userId';
}
