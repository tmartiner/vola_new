part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}

class AppUserRefreshRequested extends AppEvent {
  const AppUserRefreshRequested();
}

class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

class AppAccountDeletionRequested extends AppEvent {
  const AppAccountDeletionRequested();
}
