/*

AUTH STATES

*/

import 'package:makepost/features/auth/domain/models/app_user.dart';

abstract class AuthStates {}

class AuthInital extends AuthStates {}

class AuthLoading extends AuthStates {}

class Authenticated extends AuthStates {
  final AppUser user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthStates {}

class AuthError extends AuthStates {
  final String messages;
  AuthError(this.messages);
}
