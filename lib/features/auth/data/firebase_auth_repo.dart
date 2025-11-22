/*

  FIREBASE as our BACKEND

 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:makepost/features/auth/domain/models/app_user.dart';
import 'package:makepost/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(email: email, uid: userCredential.user!.uid);
      return user;
    } catch (e) {
      throw Exception('Login Failed...  : $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailandPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(email: email, uid: userCredential.user!.uid);
      return user;
    } catch (e) {
      throw Exception('Failed to create User...  : $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception("User not logged in ");
      }
      await user.delete();
      await logout();
    } catch (e) {
      throw Exception('Failed to delete account...  : $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) {
      return null;
    }
    return AppUser(email: currentUser.email!, uid: currentUser.uid);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email send !  check you mail";
    } catch (e) {
      return "An error occured while sending email: $e";
    }
  }
}
