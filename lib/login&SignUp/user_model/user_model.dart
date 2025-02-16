// user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final bool isActive;
  final AccountDetails accountDetails;
  final UserProfile profile;
  final UserSettings settings;
  final UserStats stats;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.createdAt,
    this.lastLogin,
    this.isActive = true,
    required this.accountDetails,
    required this.profile,
    required this.settings,
    required this.stats,
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      lastLogin: (data['lastLogin'] as Timestamp?)?.toDate(),
      isActive: data['isActive'] ?? true,
      accountDetails: AccountDetails.fromMap(data['accountDetails'] ?? {}),
      profile: UserProfile.fromMap(data['profile'] ?? {}),
      settings: UserSettings.fromMap(data['settings'] ?? {}),
      stats: UserStats.fromMap(data['stats'] ?? {}),
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'lastLogin': lastLogin != null
          ? Timestamp.fromDate(lastLogin!)
          : FieldValue.serverTimestamp(),
      'isActive': isActive,
      'accountDetails': accountDetails.toMap(),
      'profile': profile.toMap(),
      'settings': settings.toMap(),
      'stats': stats.toMap(),
    };
  }

  // Convert UserModel to Map for local storage
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'lastLogin': lastLogin?.millisecondsSinceEpoch,
      'isActive': isActive,
      'accountDetails': accountDetails.toMap(),
      'profile': profile.toMap(),
      'settings': settings.toMap(),
      'stats': stats.toMap(),
    };
  }

  // Create UserModel from local storage Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      lastLogin: map['lastLogin'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastLogin'])
          : null,
      isActive: map['isActive'] ?? true,
      accountDetails: AccountDetails.fromMap(map['accountDetails'] ?? {}),
      profile: UserProfile.fromMap(map['profile'] ?? {}),
      settings: UserSettings.fromMap(map['settings'] ?? {}),
      stats: UserStats.fromMap(map['stats'] ?? {}),
    );
  }
}

class AccountDetails {
  final String creationMethod;
  final bool emailVerified;

  AccountDetails({
    required this.creationMethod,
    required this.emailVerified,
  });

  Map<String, dynamic> toMap() => {
        'creationMethod': creationMethod,
        'emailVerified': emailVerified,
      };

  factory AccountDetails.fromMap(Map<String, dynamic> map) => AccountDetails(
        creationMethod: map['creationMethod'] ?? 'email',
        emailVerified: map['emailVerified'] ?? false,
      );
}

class UserProfile {
  final String displayName;
  final String? photoURL;
  final String bio;

  UserProfile({
    required this.displayName,
    this.photoURL,
    required this.bio,
  });

  Map<String, dynamic> toMap() => {
        'displayName': displayName,
        'photoURL': photoURL,
        'bio': bio,
      };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
        displayName: map['displayName'] ?? '',
        photoURL: map['photoURL'],
        bio: map['bio'] ?? '',
      );
}

class UserSettings {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool darkMode;

  UserSettings({
    required this.emailNotifications,
    required this.pushNotifications,
    required this.darkMode,
  });

  Map<String, dynamic> toMap() => {
        'emailNotifications': emailNotifications,
        'pushNotifications': pushNotifications,
        'darkMode': darkMode,
      };

  factory UserSettings.fromMap(Map<String, dynamic> map) => UserSettings(
        emailNotifications: map['emailNotifications'] ?? true,
        pushNotifications: map['pushNotifications'] ?? true,
        darkMode: map['darkMode'] ?? false,
      );
}

class UserStats {
  final int loginCount;
  final DateTime? lastUpdated;

  UserStats({
    required this.loginCount,
    this.lastUpdated,
  });

  Map<String, dynamic> toMap() => {
        'loginCount': loginCount,
        'lastUpdated': lastUpdated != null
            ? Timestamp.fromDate(lastUpdated!)
            : FieldValue.serverTimestamp(),
      };

  factory UserStats.fromMap(Map<String, dynamic> map) => UserStats(
        loginCount: map['loginCount'] ?? 0,
        lastUpdated: (map['lastUpdated'] as Timestamp?)?.toDate(),
      );
}
