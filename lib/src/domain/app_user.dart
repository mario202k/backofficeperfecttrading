import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppUser{
  final String id;
  final String fcmToken;
  final String platform;
  final String countryCallingCode;
  final String phoneNumber;
  final String languageCode;
  final bool isPremium;
  final bool isLogged;
  final bool hasDeletedAccount;
  final bool isOnline;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const AppUser({
    required this.id,
    required this.fcmToken,
    required this.platform,
    required this.countryCallingCode,
    required this.phoneNumber,
    required this.languageCode,
    required this.isPremium,
    required this.isLogged,
    required this.hasDeletedAccount,
    required this.isOnline,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fcmToken == other.fcmToken &&
          platform == other.platform &&
          countryCallingCode == other.countryCallingCode &&
          phoneNumber == other.phoneNumber &&
          languageCode == other.languageCode &&
          isPremium == other.isPremium &&
          isLogged == other.isLogged &&
          hasDeletedAccount == other.hasDeletedAccount &&
          isOnline == other.isOnline &&
          email == other.email &&
          password == other.password &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      fcmToken.hashCode ^
      platform.hashCode ^
      countryCallingCode.hashCode ^
      phoneNumber.hashCode ^
      languageCode.hashCode ^
      isPremium.hashCode ^
      isLogged.hashCode ^
      hasDeletedAccount.hashCode ^
      isOnline.hashCode ^
      email.hashCode ^
      password.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;


  @override
  String toString() {
    return 'AppUser{id: $id, fcmToken: $fcmToken, platform: $platform, countryCallingCode: $countryCallingCode, phoneNumber: $phoneNumber, languageCode: $languageCode, isPremium: $isPremium, isLogged: $isLogged, hasDeletedAccount: $hasDeletedAccount, isOnline: $isOnline, email: $email, password: $password, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  AppUser copyWith({
    String? id,
    String? fcmToken,
    String? platform,
    String? countryCallingCode,
    String? phoneNumber,
    String? languageCode,
    bool? isPremium,
    bool? isLogged,
    bool? hasDeletedAccount,
    bool? isOnline,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      fcmToken: fcmToken ?? this.fcmToken,
      platform: platform ?? this.platform,
      countryCallingCode: countryCallingCode ?? this.countryCallingCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      languageCode: languageCode ?? this.languageCode,
      isPremium: isPremium ?? this.isPremium,
      isLogged: isLogged ?? this.isLogged,
      hasDeletedAccount: hasDeletedAccount ?? this.hasDeletedAccount,
      isOnline: isOnline ?? this.isOnline,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fcmToken': fcmToken,
      'platform': platform,
      'countryCallingCode': countryCallingCode,
      'phoneNumber': phoneNumber,
      'languageCode': languageCode,
      'isPremium': isPremium,
      'isLogged': isLogged,
      'hasDeletedAccount': hasDeletedAccount,
      'isOnline': isOnline,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': createdAt == DateTime.now() ? FieldValue.serverTimestamp() : createdAt,
      'updatedAt': updatedAt == DateTime.now() ? FieldValue.serverTimestamp() : updatedAt,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      fcmToken: map['fcmToken'] as String,
      platform: map['platform'] as String,
      countryCallingCode: map['countryCallingCode'] as String,
      phoneNumber: map['phoneNumber'] as String,
      languageCode: map['languageCode'] as String,
      isPremium: map['isPremium'] as bool,
      isLogged: map['isLogged'] as bool,
      hasDeletedAccount: map['hasDeletedAccount'] as bool,
      isOnline: map['isOnline'] as bool,
      email: map['email'] as String,
      password: map['password'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

//</editor-fold>
}