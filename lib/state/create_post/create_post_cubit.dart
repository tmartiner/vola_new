import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../../repositories/post_repository.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepository _postRepository;

  CreatePostCubit({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(const CreatePostState());

  void captionChanged(String value) {
    try {
      emit(state.copyWith(caption: value));
    } catch (err) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  void postTypeChanged(PostType type) {
    try {
      emit(state.copyWith(type: type));
    } catch (err) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  void audienceChanged(PostAudienceSettings audience) {
    try {
      emit(state.copyWith(audience: audience));
    } catch (err) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  void replyChanged(PostReplySettings reply) {
    try {
      emit(state.copyWith(reply: reply));
    } catch (err) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  void addPostPhoto() async {
    emit(state.copyWith(photoStatus: PostPhotoStatus.loading));
    try {
      final imageUrl = await _postRepository.addPostPhoto();
      if (imageUrl == null) {
        emit(state.copyWith(photoStatus: PostPhotoStatus.error));
        return;
      }

      // TODO: Save the new image to the storage service

      emit(
        state.copyWith(
            photoStatus: PostPhotoStatus.loaded, postImageUrl: imageUrl),
      );
    } catch (err) {
      emit(state.copyWith(photoStatus: PostPhotoStatus.error));
    }
  }

  Future<void> createPost({
    required String userId,
    required String username,
    String? profileImageUrl,
  }) async {
    debugPrint('Cubit: Creating post for $state');

    if ((state.caption?.length ?? 0) > 280) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          errorMessage: 'Caption must be less than 280 characters',
        ),
      );
      emit(state.copyWith(formStatus: FormStatus.initial));
      return;
    }
    if ((state.caption?.length ?? 0) < 10) {
      emit(
        state.copyWith(
          formStatus: FormStatus.invalid,
          errorMessage: 'Caption must be at least 10 characters',
        ),
      );
      emit(state.copyWith(formStatus: FormStatus.initial));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      await _postRepository.createPost(
        userId: userId,
        username: username,
        profileImageUrl: profileImageUrl,
        postImageUrl: state.postImageUrl,
        caption: state.caption ?? '',
        type: state.type,
        audience: state.audience,
        reply: state.reply,
      );
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }
}
