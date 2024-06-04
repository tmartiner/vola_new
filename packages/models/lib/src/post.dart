import 'package:equatable/equatable.dart';

import 'post_audience_settings.dart';
import 'post_reply_settings.dart';
import 'post_type.dart';

class Post extends Equatable {
  final String id;
  final String caption;
  final String? imageUrl;
  final PostType type;
  final PostAudienceSettings audience;
  final PostReplySettings reply;
  final DateTime? createdAt;

  // User info
  final String userId;
  final String username;
  final String? profileImageUrl;

  const Post({
    required this.id,
    required this.caption,
    this.imageUrl,
    required this.type,
    required this.audience,
    required this.reply,
    this.createdAt,
    // User info
    required this.userId,
    required this.username,
    this.profileImageUrl,
  });

  Post copyWith({
    String? id,
    String? caption,
    String? imageUrl,
    PostType? type,
    PostAudienceSettings? audience,
    PostReplySettings? reply,
    DateTime? createdAt,
    String? userId,
    String? username,
    String? profileImageUrl,
  }) {
    return Post(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      audience: audience ?? this.audience,
      reply: reply ?? this.reply,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json, {String? id}) {
    return Post(
      id: id ?? json['id'] as String,
      caption: json['caption'] as String,
      type: PostType.values[json['type'] as int],
      audience: PostAudienceSettings.values[json['audience'] as int],
      reply: PostReplySettings.values[json['reply'] as int],
      userId: json['userId'] as String,
      username: json['username'] as String,
      imageUrl: json['imageUrl'] == '' ? null : json['imageUrl'] as String?,
      profileImageUrl: json['profileImageUrl'] == ''
          ? null
          : json['profileImageUrl'] as String?,
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
      'caption': caption,
      'imageUrl': imageUrl,
      'type': type.index,
      'audience': audience.index,
      'reply': reply.index,
      'userId': userId,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        caption,
        imageUrl,
        type,
        audience,
        reply,
        userId,
        username,
        profileImageUrl,
        createdAt,
      ];

  static const empty = Post(
    id: '',
    caption: '',
    type: PostType.text,
    audience: PostAudienceSettings.everyone,
    reply: PostReplySettings.everyone,
    userId: '',
    username: '',
  );
}
