import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final UserProfile profile;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profile,
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profile: UserProfile.fromMap(data['profile'] ?? {}),
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profile': profile.toMap(),
    };
  }

  // Convert UserModel to Map for local storage
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profile': profile.toMap(),
    };
  }

  // Create UserModel from local storage Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profile: UserProfile.fromMap(map['profile'] ?? {}),
    );
  }
}

class UserProfile {
  final String displayName;
  late final String? photoURL;
  final String? rank;

  UserProfile({
    required this.displayName,
    this.photoURL,
    this.rank,
  });

  Map<String, dynamic> toMap() => {
        'displayName': displayName,
        'photoURL': photoURL,
        'rank': rank,
      };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
        displayName: map['displayName'] ?? '',
        photoURL: map['photoURL'],
        rank: map['rank'],
      );
}
