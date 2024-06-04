import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../../repositories/user_repository.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final UserRepository _userRepository;

  CreateAccountCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const CreateAccountState());

  void nameChanged(String value) {
    try {
      Name name = Name((name) => name..value = value);
      emit(
        state.copyWith(
          name: name,
          nameStatus: NameStatus.valid,
        ),
      );
    } on ArgumentError catch (err) {
      emit(
        state.copyWith(
          nameStatus: NameStatus.invalid,
          nameErrorMessage: err.message,
        ),
      );
    }
  }

  void usernameChanged(String value) {
    try {
      UserName username = UserName((username) => username..value = value);
      emit(
        state.copyWith(
          username: username,
          usernameStatus: UserNameStatus.valid,
        ),
      );
    } on ArgumentError catch (err) {
      emit(
        state.copyWith(
          usernameStatus: UserNameStatus.invalid,
          usernameErrorMessage: err.message,
        ),
      );
    }
  }

  void bioChanged(String value) {
    try {
      Bio bio = Bio((bio) => bio..value = value);
      emit(
        state.copyWith(
          bio: bio,
          bioStatus: BioStatus.valid,
        ),
      );
    } on ArgumentError catch (err) {
      emit(
        state.copyWith(
          bioStatus: BioStatus.invalid,
          bioErrorMessage: err.message,
        ),
      );
    }
  }

  void dateOfBirthChanged(DateTime value) {
    try {
      DateOfBirth dateOfBirth =
          DateOfBirth((dateOfBirth) => dateOfBirth..value = value);
      emit(
        state.copyWith(
          dateOfBirth: dateOfBirth,
          dateOfBirthStatus: DateOfBirthStatus.valid,
        ),
      );
    } on ArgumentError catch (err) {
      emit(
        state.copyWith(
          dateOfBirthStatus: DateOfBirthStatus.invalid,
          dateOfBirthErrorMessage: err.message,
        ),
      );
    }
  }

  void addProfileBanner() async {
    emit(state.copyWith(profileBannerStatus: ProfileBannerStatus.loading));
    try {
      final imageUrl = await _userRepository.addUserProfileBanner();
      if (imageUrl == null) {
        emit(state.copyWith(profileBannerStatus: ProfileBannerStatus.initial));
        return;
      }

      // TODO: Save the new image to storage

      emit(
        state.copyWith(
          profileBannerUrl: imageUrl,
          profileBannerStatus: ProfileBannerStatus.loaded,
        ),
      );
    } catch (err) {
      emit(state.copyWith(profileBannerStatus: ProfileBannerStatus.error));
    }
  }

  void addProfilePhoto() async {
    emit(state.copyWith(profileImageStatus: ProfileImageStatus.loading));
    try {
      final imageUrl = await _userRepository.addUserProfilePhoto();
      if (imageUrl == null) {
        emit(state.copyWith(profileImageStatus: ProfileImageStatus.initial));
        return;
      }

      // TODO: Save the new image to storage

      emit(
        state.copyWith(
          profileImageUrl: imageUrl,
          profileImageStatus: ProfileImageStatus.loaded,
        ),
      );
    } catch (err) {
      emit(state.copyWith(profileImageStatus: ProfileImageStatus.error));
    }
  }

  Future<void> updateUser(User user) async {
    if (!(state.nameStatus == NameStatus.valid) ||
        !(state.dateOfBirthStatus == DateOfBirthStatus.valid) ||
        !(state.bioStatus == BioStatus.valid) ||
        !(state.usernameStatus == UserNameStatus.valid) ||
        !(state.profileImageStatus == ProfileImageStatus.loaded) ||
        !(state.profileBannerStatus == ProfileBannerStatus.loaded)) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      emit(state.copyWith(formStatus: FormStatus.initial));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      final updatedUser = user.copyWith(
        name: state.name?.value,
        bio: state.bio?.value,
        username: state.username?.value,
        profileImageUrl: state.profileImageUrl,
        profileBannerUrl: state.profileBannerUrl,
      );
      await _userRepository.updateMe(updatedUser);
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }
}
