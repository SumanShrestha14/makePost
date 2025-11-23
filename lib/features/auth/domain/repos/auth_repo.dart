/*

AUTH REPOSITORY : outlining the possible auth operations fot this app 

*/

import 'package:makepost/features/auth/domain/models/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailandPassword(String email, String password);
  Future<AppUser?> registerWithEmailandPassword(
    String name,
    String email,
    String password,
  );
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<String> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
}
