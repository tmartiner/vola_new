import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../../repositories/follower_repository.dart';
import '../../repositories/post_repository.dart';
import '../../repositories/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository _userRepository;
  final PostRepository _postRepository;
  final FollowerRepository _followerRepository;

  UserProfileBloc({
    required UserRepository userRepository,
    required PostRepository postRepository,
    required FollowerRepository followerRepository,
  })  : _userRepository = userRepository,
        _postRepository = postRepository,
        _followerRepository = followerRepository,
        super(const UserProfileState()) {
    on<LoadUserProfileEvent>(_loadUserProfileEvent);
    on<EditNameEvent>(_editName);
    on<EditUserNameEvent>(_editUserName);
    on<EditBioEvent>(_editBio);
    on<EditEmailEvent>(_editEmail);
    on<AddProfilePhotoEvent>(_onAddProfilePhoto);
    on<AddProfileBannerEvent>(_onAddProfileBanner);
    on<UpdateUserProfileEvent>(_updateUserAccount);
  }

  void _loadUserProfileEvent(
    LoadUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      if (event.userId == null) {
        emit(state.copyWith(status: UserProfileStatus.initial));
        return;
      }

      final futureUser = _userRepository.fetchUser(event.userId!);
      final futurePosts = _postRepository.fetchPostsByUserId(event.userId!);
      final futureFollowers = _followerRepository.fetchFollowers(event.userId!);
      final futureFollowing = _followerRepository.fetchFollowing(event.userId!);
      final results = await Future.wait([
        futureUser,
        futurePosts,
        futureFollowers,
        futureFollowing,
      ]);

      final user = results[0] as User;
      final posts = results[1] as List<Post>;
      final followers = results[2] as List<Follower>;
      final following = results[3] as List<Follower>;

      print('Followers: ${followers.length}');
      print('Followings: ${following.length}');

      posts.sort((a, b) {
        final aCreatedAt = a.createdAt ?? -1;
        final bCreatedAt = b.createdAt ?? -1;

        if (aCreatedAt == -1 && bCreatedAt != -1) {
          return -1;
        }
        if (aCreatedAt != -1 && bCreatedAt == -1) {
          return 1;
        }

        return b.createdAt!.compareTo(a.createdAt!);
      });

      emit(
        state.copyWith(
          status: UserProfileStatus.loaded,
          user: user.copyWith(
            followerCount: followers.length,
            followingCount: following.length,
          ),
          posts: posts,
          followers: followers,
          following: following,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _editName(
    EditNameEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      emit(
        state.copyWith(
          status: UserProfileStatus.loaded,
          user: state.user?.copyWith(name: event.name),
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _editUserName(
    EditUserNameEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      emit(
        state.copyWith(
          status: UserProfileStatus.loaded,
          user: state.user?.copyWith(username: event.username),
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _editBio(
    EditBioEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      emit(
        state.copyWith(
          status: UserProfileStatus.loaded,
          user: state.user?.copyWith(bio: event.bio),
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _editEmail(
    EditEmailEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      emit(
        state.copyWith(
          status: UserProfileStatus.loaded,
          user: state.user?.copyWith(
            email: Email((email) => email.value = event.email),
          ),
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _onAddProfilePhoto(
    AddProfilePhotoEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(photoStatus: UserProfilePhotoStatus.loading));
    try {
      final downloadUrl = await _userRepository.addUserProfilePhoto();
      if (downloadUrl == null) {
        emit(state.copyWith(photoStatus: UserProfilePhotoStatus.initial));
        return;
      }

      // TODO: Save the new image URL to the user's profile
      // await _userRepository.updateUser(
      //   state.user!.id,
      //   state.user!.copyWith(profileImageUrl: downloadUrl).toJson(),
      // );

      emit(
        state.copyWith(
          user: state.user?.copyWith(profileImageUrl: downloadUrl),
          status: UserProfileStatus.loaded,
          photoStatus: UserProfilePhotoStatus.loaded,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _onAddProfileBanner(
    AddProfileBannerEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(bannerStatus: UserProfileBannerStatus.loading));
    try {
      final downloadUrl = await _userRepository.addUserProfileBanner();
      if (downloadUrl == null) {
        emit(state.copyWith(bannerStatus: UserProfileBannerStatus.initial));
        return;
      }

      // TODO: Save the new image URL to the user's profile
      // await _userRepository.updateUser(
      //   state.user!.id,
      //   state.user!.copyWith(profileBannerUrl: imageUrl).toJson(),
      // );

      emit(
        state.copyWith(
          user: state.user?.copyWith(profileBannerUrl: downloadUrl),
          status: UserProfileStatus.loaded,
          bannerStatus: UserProfileBannerStatus.loaded,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }

  void _updateUserAccount(
    UpdateUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: UserProfileStatus.loading));
    try {
      if (state.user != null) {
        await _userRepository.updateMe(state.user!);
        emit(state.copyWith(status: UserProfileStatus.loaded));
      }
    } catch (err) {
      emit(state.copyWith(status: UserProfileStatus.error));
    }
  }
}
