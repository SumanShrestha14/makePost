/*

CUBITS ARE RESPONSIBLE FOR STATE MANAGEMENT->show appropriate data on the screen

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makepost/features/auth/domain/models/app_user.dart';
import 'package:makepost/features/auth/domain/repos/auth_repo.dart';
import 'package:makepost/features/auth/presentation/cubits/auth_states.dart';

class AuthCubits extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubits({required this.authRepo}) : super(AuthInital());

  // getCurrentUser

  AppUser? get currentUser => _currentUser;

  // check if user is Authenticated
  void checkIsAuthenticated() async {
    emit(AuthLoading());
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  }

  // TODO:  login with email and password
}
