part of 'create_account_cubit.dart';

enum ProfileImageStatus { initial, loading, loaded, error }

enum ProfileBannerStatus { initial, loading, loaded, error }

class CreateAccountState extends Equatable {
  final Name? name;
  final DateOfBirth? dateOfBirth;
  final Bio? bio;
  final UserName? username;
  final String? profileImageUrl;
  final String? profileBannerUrl;
  final NameStatus nameStatus;
  final DateOfBirthStatus dateOfBirthStatus;
  final BioStatus bioStatus;
  final UserNameStatus usernameStatus;
  final ProfileBannerStatus profileBannerStatus;
  final ProfileImageStatus profileImageStatus;
  final String? nameErrorMessage;
  final String? dateOfBirthErrorMessage;
  final String? bioErrorMessage;
  final String? usernameErrorMessage;
  final FormStatus formStatus;

  const CreateAccountState({
    this.name,
    this.dateOfBirth,
    this.bio,
    this.username,
    this.profileImageUrl,
    this.profileBannerUrl,
    this.nameStatus = NameStatus.unknown,
    this.dateOfBirthStatus = DateOfBirthStatus.unknown,
    this.bioStatus = BioStatus.unknown,
    this.usernameStatus = UserNameStatus.unknown,
    this.profileBannerStatus = ProfileBannerStatus.initial,
    this.profileImageStatus = ProfileImageStatus.initial,
    this.nameErrorMessage,
    this.dateOfBirthErrorMessage,
    this.bioErrorMessage,
    this.usernameErrorMessage,
    this.formStatus = FormStatus.initial,
  });

  CreateAccountState copyWith({
    Name? name,
    DateOfBirth? dateOfBirth,
    Bio? bio,
    UserName? username,
    String? profileImageUrl,
    String? profileBannerUrl,
    NameStatus? nameStatus,
    DateOfBirthStatus? dateOfBirthStatus,
    BioStatus? bioStatus,
    UserNameStatus? usernameStatus,
    ProfileBannerStatus? profileBannerStatus,
    ProfileImageStatus? profileImageStatus,
    String? nameErrorMessage,
    String? dateOfBirthErrorMessage,
    String? bioErrorMessage,
    String? usernameErrorMessage,
    FormStatus? formStatus,
  }) {
    return CreateAccountState(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      profileBannerUrl: profileBannerUrl ?? this.profileBannerUrl,
      nameStatus: nameStatus ?? this.nameStatus,
      dateOfBirthStatus: dateOfBirthStatus ?? this.dateOfBirthStatus,
      bioStatus: bioStatus ?? this.bioStatus,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      profileBannerStatus: profileBannerStatus ?? this.profileBannerStatus,
      profileImageStatus: profileImageStatus ?? this.profileImageStatus,
      nameErrorMessage: nameErrorMessage ?? this.nameErrorMessage,
      dateOfBirthErrorMessage:
          dateOfBirthErrorMessage ?? this.dateOfBirthErrorMessage,
      bioErrorMessage: bioErrorMessage ?? this.bioErrorMessage,
      usernameErrorMessage: usernameErrorMessage ?? this.usernameErrorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  bool get formComplete {
    return nameStatus == NameStatus.valid &&
        dateOfBirthStatus == DateOfBirthStatus.valid &&
        bioStatus == BioStatus.valid &&
        usernameStatus == UserNameStatus.valid &&
        profileBannerStatus == ProfileBannerStatus.loaded &&
        profileImageStatus == ProfileImageStatus.loaded;
  }

  @override
  List<Object?> get props => [
        name,
        dateOfBirth,
        bio,
        username,
        profileImageUrl,
        profileBannerUrl,
        nameStatus,
        dateOfBirthStatus,
        bioStatus,
        usernameStatus,
        profileBannerStatus,
        profileImageStatus,
        nameErrorMessage,
        dateOfBirthErrorMessage,
        bioErrorMessage,
        usernameErrorMessage,
        formStatus,
      ];
}
