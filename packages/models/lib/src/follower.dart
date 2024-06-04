import 'package:equatable/equatable.dart';

class Follower extends Equatable {
  final String id;
  final String followerId;
  final String followerHandle;
  final String followerUsername;
  final String? followerProfileImageUrl;
  final String followingId;
  final String followingHandle;
  final String followingUsername;
  final String? followingProfileImageUrl;
  final DateTime? createdAt;

  const Follower({
    required this.id,
    required this.followerId,
    required this.followerHandle,
    required this.followerUsername,
    this.followerProfileImageUrl,
    required this.followingId,
    required this.followingHandle,
    required this.followingUsername,
    this.followingProfileImageUrl,
    this.createdAt,
  });

  factory Follower.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return Follower(
      id: id ?? json['id'],
      followerId: json['followerId'],
      followerHandle: json['followerHandle'],
      followerUsername: json['followerUsername'],
      followerProfileImageUrl: json['followerProfileImageUrl'] as String?,
      followingId: json['followingId'],
      followingHandle: json['followingHandle'],
      followingUsername: json['followingUsername'],
      followingProfileImageUrl: json['followingProfileImageUrl'] as String?,
      createdAt: (json['createdAt'] != null)
          ? (json['createdAt'] is DateTime)
              ? json['createdAt']
              : (json['createdAt'] is String)
                  ? DateTime.parse(json['createdAt'])
                  : json['createdAt'].toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'followerId': followerId,
      'followerHandle': followerHandle,
      'followerUsername': followerUsername,
      'followerProfileImageUrl': followerProfileImageUrl,
      'followingId': followingId,
      'followingHandle': followingHandle,
      'followingUsername': followingUsername,
      'followingProfileImageUrl': followingProfileImageUrl,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        followerId,
        followerHandle,
        followerUsername,
        followerProfileImageUrl,
        followingId,
        followingHandle,
        followingUsername,
        followingProfileImageUrl,
        createdAt,
      ];
}
