import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions/app_exception.dart';

const timeOutSecond = 120;

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  void setData({
    required String path,
    required Map<String, dynamic> data,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    reference
        .set(data, SetOptions(merge: true))
        .timeout(const Duration(seconds: timeOutSecond))
        .catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is TimeoutException) {
        throw const AppException.timeOut();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }


  Future<void> setDataWithAwait({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference
        .set(data, SetOptions(merge: true))
        .timeout(const Duration(seconds: timeOutSecond))
        .catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is TimeoutException) {
        throw const AppException.timeOut();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  Future<void> updateData({
    required String path,
    required MapEntry<String, dynamic> data,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference
        .update({data.key: data.value})
        .timeout(const Duration(seconds: timeOutSecond))
        .catchError((onError) {
          if (onError is SocketException) {
            throw const AppException.noInternet();
          } else if (onError is TimeoutException) {
            throw const AppException.timeOut();
          } else if (onError is FirebaseException) {
            firebaseExceptionToReadableError(onError);
          } else {
            throw AppException.unknown(onError.toString());
          }
        });
  }

  void firebaseExceptionToReadableError(FirebaseException e) {
    switch (e.code) {
      case "aborted":
        throw const AppException.aborted();
      case "already_exists":
        throw const AppException.alreadyExists();
      case "cancelled":
        throw const AppException.cancelled();
      case "data_loss":
        throw const AppException.dataLoss();
      case "deadline_exceeded":
        throw const AppException.deadlineExceeded();
      case "failed_precondition":
        throw const AppException.failedPrecondition();
      case "internal":
        throw const AppException.internal();
      case "invalid_argument":
        throw const AppException.invalidArgument();
      case "not_found":
        throw const AppException.notFound();
      case "ok":
        throw const AppException.ok();
      case "out_of_range":
        throw const AppException.outOfRange();
      case "permission_denied":
        throw const AppException.permissionDenied();
      case "resource_exhausted":
        throw const AppException.resourceExhausted();
      case "unauthenticated":
        throw const AppException.unauthenticated();
      case "unavailable":
        throw const AppException.unavailable();
      case "unimplemented":
        throw const AppException.unimplemented();
      case "unknown":
        throw AppException.unknown(e.message ?? e.code);
      default:
        throw const AppException.noInternet();
    }
  }

  Future<void> updateDataWithAwait({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference
        .update(data)
        .timeout(const Duration(seconds: timeOutSecond))
        .catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else if (onError is TimeoutException) {
        throw const AppException.timeOut();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  Future<void> deleteDoc({required String path}) {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference
        .delete()
        .timeout(const Duration(seconds: timeOutSecond))
        .catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else if (onError is TimeoutException) {
        throw const AppException.timeOut();
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
  }

  Future<void> deleteCollection({required String path}) async {
    final reference = FirebaseFirestore.instance.collection(path);

    final query = await reference.get();

    for (final doc in query.docs) {
      doc.reference
          .delete()
          .timeout(const Duration(seconds: timeOutSecond))
          .catchError((onError) {
        if (onError is SocketException) {
          throw const AppException.noInternet();
        } else if (onError is FirebaseException) {
          firebaseExceptionToReadableError(onError);
        } else if (onError is TimeoutException) {
          throw const AppException.timeOut();
        } else {
          throw AppException.unknown(onError.toString());
        }
      });
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
    Query<Map<String, dynamic>?> Function(Query<Map<String, dynamic>?> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>?> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot<Map<String, dynamic>?>> snapshots =
        query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data()))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
  Stream<int> getCollectionCountStream({
    required String path,
    Query<Map<String, dynamic>?> Function(Query<Map<String, dynamic>?> query)?
        queryBuilder,
  }) {
    Query<Map<String, dynamic>?> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot<Map<String, dynamic>?>> snapshots =
        query.snapshots();

    return snapshots.map((snapshot) {

      return snapshot.docs.length;

    });

  }

  Stream<List<T>> collectionGroupStream<T>({
    required String path,
    T Function(Map<String, dynamic>? data)? builder,
    Query<Map<String, dynamic>?> Function(Query<Map<String, dynamic>?> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>?> query =
        FirebaseFirestore.instance.collectionGroup(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot<Map<String, dynamic>?>> snapshots =
        query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder!(snapshot.data()))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<List<T>> collectionFuture<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final QuerySnapshot<Map<String, dynamic>> docs = await query
        .get()
        .timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
      throw const AppException.timeOut();
    }).catchError((onError) {
      print(onError);
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });

    final result = docs.docs
        .map((e) => builder(e.data()))
        .where((element) => element != null)
        .toList();

    if (sort != null) {
      result.sort(sort);
    }

    return result;
  }

  String currentMenuTag = '';
  bool hasNext = true;
  DocumentSnapshot? lastDocument;

  Future<List<T>> collectionFuturePagination<T>({
    required int documentLimit,
    required String menuTag,
    required String path,
    required T Function(Map<String, dynamic> data) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    if (currentMenuTag != menuTag) {
      currentMenuTag = menuTag;
      hasNext = true;
      lastDocument = null;
    }
    if (!hasNext) {
      return <T>[];
    }
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);

    if (lastDocument != null) {
      query = query
          .orderBy('date', descending: true)
          .startAfterDocument(lastDocument!)
          .limit(documentLimit);
    } else {
      query = query.orderBy('date', descending: true).limit(documentLimit);
    }

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final QuerySnapshot<Map<String, dynamic>> docs = await query
        .get()
        .timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
      throw const AppException.timeOut();
    }).catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });
    if (docs.docs.isEmpty) {
      hasNext = false;
      lastDocument = null;
      return <T>[];
    }
    lastDocument = docs.docs.last;
    if (docs.docs.length < documentLimit) {
      hasNext = false;
      lastDocument = null;
    }
    final result = docs.docs
        .map((e) => builder(e.data()))
        .where((element) => element != null)
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }

  Future<List<T>> collectionGroupFuture<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collectionGroup(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final QuerySnapshot<Map<String, dynamic>> docs = await query
        .get()
        .timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
      throw const AppException.timeOut();
    }).catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });

    final result = docs.docs
        .map((e) => builder(e.data()))
        .where((element) => element != null)
        .toList();

    if (sort != null) {
      result.sort(sort);
    }

    return result;
  }

  Future<T> getDoc<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    final DocumentReference<Map<String, dynamic>> reference =
        FirebaseFirestore.instance.doc(path);
    final DocumentSnapshot<Map<String, dynamic>> doc = await reference
        .get()
        .timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
      throw const AppException.timeOut();
    }).catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });

    return builder(doc.data()!);
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
  }) {
    final DocumentReference<Map<String, dynamic>?> reference =
        FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>?>> snapshots =
        reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()));
  }

  Query<Map<String, dynamic>?> getQuery(
      {required String path,
      Query<Map<String, dynamic>?> Function(Query<Map<String, dynamic>?> query)?
          queryBuilder}) {
    Query<Map<String, dynamic>?> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query;
  }

  String getDocId<T>({
    required String path,
  }) {
    return FirebaseFirestore.instance.collection(path).doc().id;
  }

  Future<int> getNumberOfDocuments(
      {required String path, Query Function(Query query)? queryBuilder}) async {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final QuerySnapshot docs = await query
        .get()
        .timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
      throw const AppException.timeOut();
    }).catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });

    final result = docs.docs.length;

    return result;
  }

  Future<bool> ifDocumentExist(
      {required String pathToCollection, required String docId}) async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection(pathToCollection)
            .doc(docId)
            .get()
            .timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
      throw const AppException.timeOut();
    }).catchError((onError) {
      if (onError is SocketException) {
        throw const AppException.noInternet();
      } else if (onError is FirebaseException) {
        firebaseExceptionToReadableError(onError);
      } else {
        throw AppException.unknown(onError.toString());
      }
    });

    return documentSnapshot.exists;
  }
}
