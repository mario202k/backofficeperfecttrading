import 'package:cloud_firestore/cloud_firestore.dart';

class AppVersion {
  final String version;
  final String appStoreUrl;
  final String playStoreUrl;
  final String whatsNew;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const AppVersion({
    required this.version,
    required this.appStoreUrl,
    required this.playStoreUrl,
    required this.whatsNew,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppVersion &&
          runtimeType == other.runtimeType &&
          version == other.version &&
          appStoreUrl == other.appStoreUrl &&
          playStoreUrl == other.playStoreUrl &&
          whatsNew == other.whatsNew &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      version.hashCode ^
      appStoreUrl.hashCode ^
      playStoreUrl.hashCode ^
      whatsNew.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'LastAppVersion{ version: $version, appStoreUrl: $appStoreUrl, playStoreUrl: $playStoreUrl, whatsNew: $whatsNew, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  AppVersion copyWith({
    String? version,
    String? appStoreUrl,
    String? playStoreUrl,
    String? whatsNew,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppVersion(
      version: version ?? this.version,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      whatsNew: whatsNew ?? this.whatsNew,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'appStoreUrl': appStoreUrl,
      'playStoreUrl': playStoreUrl,
      'whatsNew': whatsNew,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AppVersion.fromMap(Map<String, dynamic> map) {
    return AppVersion(
      version: map['version'] as String,
      appStoreUrl: map['appStoreUrl'] as String,
      playStoreUrl: map['playStoreUrl'] as String,
      whatsNew: map['whatsNew'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}
