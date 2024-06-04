part of 'create_post_cubit.dart';

enum PostPhotoStatus { initial, loading, loaded, error }

class CreatePostState extends Equatable {
  final String? caption;
  final PostType type;
  final PostAudienceSettings audience;
  final PostReplySettings reply;
  final String? postImageUrl;
  final PostPhotoStatus photoStatus;
  final String? errorMessage;
  final FormStatus formStatus;

  const CreatePostState({
    this.caption,
    this.type = PostType.text,
    this.audience = PostAudienceSettings.everyone,
    this.reply = PostReplySettings.everyone,
    this.postImageUrl,
    this.photoStatus = PostPhotoStatus.initial,
    this.errorMessage,
    this.formStatus = FormStatus.initial,
  });

  CreatePostState copyWith({
    String? caption,
    PostType? type,
    PostAudienceSettings? audience,
    PostReplySettings? reply,
    String? postImageUrl,
    PostPhotoStatus? photoStatus,
    String? errorMessage,
    FormStatus? formStatus,
  }) {
    return CreatePostState(
      caption: caption ?? this.caption,
      type: type ?? this.type,
      audience: audience ?? this.audience,
      reply: reply ?? this.reply,
      postImageUrl: postImageUrl ?? this.postImageUrl,
      photoStatus: photoStatus ?? this.photoStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        caption,
        type,
        audience,
        reply,
        postImageUrl,
        photoStatus,
        errorMessage,
        formStatus,
      ];
}
