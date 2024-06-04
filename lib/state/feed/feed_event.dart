part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FeedLoadEvent extends FeedEvent {
  final String userId;

  const FeedLoadEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class FeedCreateEvent extends FeedEvent {
  final Post post;

  const FeedCreateEvent(this.post);

  @override
  List<Object> get props => [post];
}

class FeedDeleteEvent extends FeedEvent {
  final Post post;

  const FeedDeleteEvent(this.post);

  @override
  List<Object> get props => [post];
}
