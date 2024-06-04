import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late StreamSubscription<User?>? _authUserSubscription;

  AppBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    User? user,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(
          user == null
              ? const AppState(
                  status: AppStatus.unauthenticated,
                  user: User.anonymous,
                )
              : AppState(
                  status: AppStatus.authenticated,
                  user: user,
                ),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppUserRefreshRequested>(_onUserRefreshRequested);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppAccountDeletionRequested>(_onAccountDeletionRequested);

    _authUserSubscription =
        _authRepository.authStateChanges.listen((User? user) {
      _userChanged(user);
    });
  }

  void _userChanged(User? user) async {
    debugPrint('User changed: $user');
    int retries = 0;
    try {
      if (user != null) {
        final updatedUser = await _userRepository.fetchMe(userId: user.id);
        add(AppUserChanged(updatedUser));
      } else {
        add(AppUserChanged(user));
      }
    } on UserNotFoundException {
      if (retries == 0) {
        retries++;
        final newUser = await _userRepository.createMe(
          data: user?.toJson() ?? {},
        );
        add(AppUserChanged(newUser));
      }
    } catch (err) {
      add(AppUserChanged(user));
    }
  }

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) async {
    if (event.user == null) {
      emit(
        state.copyWith(
          status: AppStatus.unauthenticated,
          user: User.anonymous,
        ),
      );
    } else {
      emit(state.copyWith(status: AppStatus.authenticated, user: event.user));
    }
  }

  void _onUserRefreshRequested(
    AppUserRefreshRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      if (state.user?.id == null) return;
      final user = await _userRepository.fetchMe(userId: state.user!.id);
      add(AppUserChanged(user));
    } catch (err) {}
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      unawaited(_authRepository.logout());
    } catch (err) {
      print(err);
    }
  }

  void _onAccountDeletionRequested(
    AppAccountDeletionRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      _authUserSubscription?.cancel();
      await _authRepository.deleteAccount();
    } catch (err) {}
  }

  @override
  Future<void> close() {
    _authUserSubscription?.cancel();
    return super.close();
  }
}
