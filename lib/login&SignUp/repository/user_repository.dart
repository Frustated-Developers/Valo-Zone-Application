import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valo_zone/login&SignUp/user_model/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final SharedPreferences _prefs;

  static const String _userKey = 'current_user';

  UserRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required SharedPreferences prefs,
  })  : _firestore = firestore,
        _auth = auth,
        _prefs = prefs;

  // Create or update user data
  Future<void> saveUser(UserModel user) async {
    try {
      // Save to Firebase
      await _firestore.collection('users').doc(user.uid).set(
            user.toFirestore(),
            SetOptions(merge: true),
          );

      // Save to local storage
      await _prefs.setString(_userKey, json.encode(user.toMap()));
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  // Get user data from Firebase
  Future<UserModel?> getUserFromFirebase(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data from Firebase: $e');
    }
  }

  // Get user data from local storage
  UserModel? getUserFromLocal() {
    try {
      String? userData = _prefs.getString(_userKey);
      if (userData != null) {
        return UserModel.fromMap(json.decode(userData));
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data from local storage: $e');
    }
  }

  // Create user with email signup
  Future<UserModel> createUserWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: credential.user!.uid,
        username: username,
        email: email,
        accountDetails: AccountDetails(
          creationMethod: 'email',
          emailVerified: credential.user!.emailVerified,
        ),
        profile: UserProfile(
          displayName: username,
          photoURL: null,
          bio: '',
        ),
        settings: UserSettings(
          emailNotifications: true,
          pushNotifications: true,
          darkMode: false,
        ),
        stats: UserStats(
          loginCount: 1,
          lastUpdated: DateTime.now(),
        ),
      );

      await saveUser(user);
      return user;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Create user with Google Sign In
  Future<UserModel> createUserWithGoogle(UserCredential credential) async {
    try {
      User? googleUser = credential.user;
      if (googleUser == null) throw Exception('Google sign in failed');

      UserModel user = UserModel(
        uid: googleUser.uid,
        username: googleUser.displayName ?? '',
        email: googleUser.email ?? '',
        accountDetails: AccountDetails(
          creationMethod: 'google',
          emailVerified: googleUser.emailVerified,
        ),
        profile: UserProfile(
          displayName: googleUser.displayName ?? '',
          photoURL: googleUser.photoURL,
          bio: '',
        ),
        settings: UserSettings(
          emailNotifications: true,
          pushNotifications: true,
          darkMode: false,
        ),
        stats: UserStats(
          loginCount: 1,
          lastUpdated: DateTime.now(),
        ),
      );

      await saveUser(user);
      return user;
    } catch (e) {
      throw Exception('Failed to create user with Google: $e');
    }
  }

  // Update user login stats
  Future<void> updateLoginStats(String uid) async {
    try {
      UserModel? user = await getUserFromFirebase(uid);
      if (user != null) {
        UserModel updatedUser = UserModel(
          uid: user.uid,
          username: user.username,
          email: user.email,
          lastLogin: DateTime.now(),
          isActive: true,
          accountDetails: user.accountDetails,
          profile: user.profile,
          settings: user.settings,
          stats: UserStats(
            loginCount: user.stats.loginCount + 1,
            lastUpdated: DateTime.now(),
          ),
        );
        await saveUser(updatedUser);
      }
    } catch (e) {
      throw Exception('Failed to update login stats: $e');
    }
  }
}
