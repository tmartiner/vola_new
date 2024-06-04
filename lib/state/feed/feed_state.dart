part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, loaded, error }

class FeedState extends Equatable {
  final FeedStatus status;
  final List<Post> forYouPosts;
  final List<Post> followingPosts;

  const FeedState({
    this.status = FeedStatus.initial,
    this.forYouPosts = const [],
    this.followingPosts = const [],
  });

  FeedState copyWith({
    FeedStatus? status,
    List<Post>? forYouPosts,
    List<Post>? followingPosts,
  }) {
    return FeedState(
      status: status ?? this.status,
      forYouPosts: forYouPosts ?? this.forYouPosts,
      followingPosts: followingPosts ?? this.followingPosts,
    );
  }

  @override
  List<Object?> get props => [status, forYouPosts, followingPosts];
}
