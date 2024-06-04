import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../../repositories/post_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository _postRepository;

  FeedBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const FeedState()) {
    on<FeedLoadEvent>(_onLoadFeed);
    on<FeedDeleteEvent>(_onDeletePost);
  }

  Future<void> _onLoadFeed(
    FeedLoadEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(state.copyWith(status: FeedStatus.loading));
    try {
      // final futureFollowingPost = _postRepository.fetchFollowingPost(
      //   event.userId,
      // );
      final futureForYouPost = _postRepository.fetchForYouPost(event.userId);

      final results = await Future.wait([
        // futureFollowingPost,
        futureForYouPost,
      ]);

      // final followingPost = results[0];
      final forYouPost = results[0];

      // followingPost.sort((a, b) {
      //   final aCreatedAt = a.createdAt ?? -1;
      //   final bCreatedAt = b.createdAt ?? -1;

      //   if (aCreatedAt == -1 && bCreatedAt != -1) {
      //     return 1;
      //   }
      //   if (aCreatedAt != -1 && bCreatedAt == -1) {
      //     return -1;
      //   }

      //   return b.createdAt!.compareTo(a.createdAt!);
      // });

      forYouPost.sort((a, b) {
        final aCreatedAt = a.createdAt ?? -1;
        final bCreatedAt = b.createdAt ?? -1;

        if (aCreatedAt == -1 && bCreatedAt != -1) {
          return 1;
        }
        if (aCreatedAt != -1 && bCreatedAt == -1) {
          return -1;
        }

        return b.createdAt!.compareTo(a.createdAt!);
      });

      emit(
        state.copyWith(
          status: FeedStatus.loaded,
          // followingPosts: followingPost,
          forYouPosts: forYouPost,
        ),
      );
    } catch (err) {
      print(err);
      emit(state.copyWith(status: FeedStatus.error));
    }
  }

  Future<void> _onDeletePost(
    FeedDeleteEvent event,
    Emitter<FeedState> emit,
  ) async {
    try {
      await _postRepository.deletePost(event.post);
      // _onLoadFeed(FeedLoadEvent(), emit);
    } catch (err) {
      emit(state.copyWith(status: FeedStatus.error));
    }
  }
}
