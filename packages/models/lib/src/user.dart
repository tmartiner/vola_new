import 'package:equatable/equatable.dart';
import 'package:models/models.dart';

class User extends Equatable {
  final String id;
  final Email? email;
  final String? namee;
  final String? name;
  final String? handle;
  final String? bio;
  final String? username;
  final String? profileImageUrl;
  final String? profileBannerUrl;
  final int? followerCount;
  final int? followingCount;

  const User({
    required this.id,
    this.email,
    this.namee,
    this.name,
    this.handle,
    this.bio,
    this.username,
    this.profileImageUrl,
    this.profileBannerUrl,
    this.followerCount,
    this.followingCount,
  });

  User copyWith({
    String? id,
    Email? email,
    String? namee,
    String? name,
    String? handle,
    String? bio,
    String? username,
    String? profileImageUrl,
    String? profileBannerUrl,
    int? followerCount,
    int? followingCount,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      namee: namee ?? this.namee,
      name: name ?? this.name,
      handle: handle ?? this.handle,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      profileBannerUrl: profileBannerUrl ?? this.profileBannerUrl,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }

  factory User.fromJson(Map<String, dynamic> json, {String? id}) {
    return User(
      id: id ?? json['id'] as String,
      email: json['email'] == null
          ? null
          : Email(
              (b) => b..value = json['email'],
            ),
      namee: json['name1'] as String?,
      name: json['name'] as String?,
      handle: json['handle'] as String?,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      profileBannerUrl: json['profileBannerUrl'] as String?,
      followerCount: json['followerCount'] as int?,
      followingCount: json['followingCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email?.value,
      'name1': namee,
      'name': name,
      'handle': handle,
      'bio': bio,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'profileBannerUrl': profileBannerUrl,
      'followerCount': followerCount,
      'followingCount': followingCount,
    };
  }

  /// Whether the current user is anonymous.
  bool get isAnonymous => this == anonymous;

  // Get the initials of the user.
  String get initials => username?.substring(0, 2).toUpperCase() ?? '';

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = User(id: '');

  @override
  List<Object?> get props => [
        id,
        namee,
        email,
        name,
        handle,
        bio,
        username,
        profileImageUrl,
        profileBannerUrl,
        followerCount,
        followingCount,
      ];
}
