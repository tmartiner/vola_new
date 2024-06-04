part of 'app_bloc.dart';

enum AppStatus { unknown, authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus status;
  final User? user;

  const AppState({required this.status, this.user});

  AppState copyWith({AppStatus? status, User? user}) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
