part of 'user_profile_bloc.dart';

enum UserProfileStatus { initial, loading, loaded, error }

enum UserProfilePhotoStatus { initial, loading, loaded, error }

enum UserProfileBannerStatus { initial, loading, loaded, error }

class UserProfileState extends Equatable {
  final UserProfileStatus status;
  final UserProfilePhotoStatus photoStatus;
  final UserProfileBannerStatus bannerStatus;
  final User? user;
  final List<Post> posts;
  final List<Follower> followers;
  final List<Follower> following;

  const UserProfileState({
    this.status = UserProfileStatus.initial,
    this.photoStatus = UserProfilePhotoStatus.initial,
    this.bannerStatus = UserProfileBannerStatus.initial,
    this.user,
    this.posts = const [],
    this.followers = const [],
    this.following = const [],
  });

  UserProfileState copyWith({
    UserProfileStatus? status,
    UserProfilePhotoStatus? photoStatus,
    UserProfileBannerStatus? bannerStatus,
    User? user,
    List<Post>? posts,
    List<Follower>? followers,
    List<Follower>? following,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      photoStatus: photoStatus ?? this.photoStatus,
      bannerStatus: bannerStatus ?? this.bannerStatus,
      user: user ?? this.user,
      posts: posts ?? this.posts,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  @override
  List<Object?> get props => [
        status,
        photoStatus,
        bannerStatus,
        user,
        posts,
        followers,
        following,
      ];
}
