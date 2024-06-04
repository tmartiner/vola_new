part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfileEvent extends UserProfileEvent {
  final String? userId;

  const LoadUserProfileEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class EditNameEvent extends UserProfileEvent {
  final String? name;

  const EditNameEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class EditUserNameEvent extends UserProfileEvent {
  final String? username;

  const EditUserNameEvent({required this.username});

  @override
  List<Object?> get props => [username];
}

class EditBioEvent extends UserProfileEvent {
  final String? bio;

  const EditBioEvent({required this.bio});

  @override
  List<Object?> get props => [bio];
}

class EditEmailEvent extends UserProfileEvent {
  final String? email;

  const EditEmailEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class UpdateUserProfileEvent extends UserProfileEvent {}

class AddProfilePhotoEvent extends UserProfileEvent {}

class AddProfileBannerEvent extends UserProfileEvent {}
