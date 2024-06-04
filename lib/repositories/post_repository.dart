import 'package:db_client/common.dart';
import 'package:file_upload_client/file_upload_client.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class PostRepository {
  final DbClient dbClient;
  final FileUploadClient fileUploadClient;

  PostRepository({
    required this.dbClient,
    required this.fileUploadClient,
  });

  Future<String> createPost({
    required String userId,
    required String username,
    required String caption,
    required PostType type,
    required PostAudienceSettings audience,
    required PostReplySettings reply,
    String? profileImageUrl,
    String? postImageUrl,
  }) async {
    debugPrint('Creating post');
    final postId = await dbClient.add(entity: 'posts', data: {
      'userId': userId,
      'username': username,
      'caption': caption,
      'type': type.index,
      'audience': audience.index,
      'reply': reply.index,
      'profileImageUrl': profileImageUrl,
      'imageUrl': postImageUrl,
      'createdAt': DateTime.now(),
    });
    return postId;
  }

  Future<String?> addPostPhoto() async {
    try {
      final filePath = await fileUploadClient.pickImage();
      if (filePath == null) {
        return null;
      } else {
        final imageUrl = await fileUploadClient.uploadImage(filePath);
        return imageUrl;
      }
    } catch (err) {
      throw Exception('Failed to add post  photo: $err');
    }
  }

  Future<List<Post>> fetchPostsByUserId(String userId) async {
    try {
      final postFilter = Filter();
      postFilter.addCondition(IsEqualTo(userId));

      final postData = await dbClient.fetchAllBy(
        entity: 'posts',
        filters: {'userId': postFilter.toJson()['conditions']},
      );

      return postData
          .map(
            (record) {
              try {
                // Try to parse the post
                return Post.fromJson(record.data, id: record.id);
              } catch (err) {
                // If there is an error parsing the post, return null
                return null;
              }
            },
          )
          .where((post) => post != null)
          .cast<Post>()
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch posts by user id: $err');
    }
  }

  Future<List<Post>> fetchForYouPost(String userId) async {
    try {
      final postData = await dbClient.fetchAll(entity: 'posts');
      return postData
          .map(
            (record) {
              try {
                // Try to parse the post
                return Post.fromJson(record.data, id: record.id);
              } catch (err) {
                // If there is an error parsing the post, return null
                return null;
              }
            },
          )
          .where((post) => post != null)
          .cast<Post>()
          .where((post) => post.userId != userId)
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch for you post: $err');
    }
  }

  Future<List<Post>> fetchFollowingPost(String userId) async {
    try {
      final postData = await dbClient.fetchAll(entity: 'posts');
      return postData
          .map(
            (record) {
              try {
                // Try to parse the post
                return Post.fromJson(record.data, id: record.id);
              } catch (err) {
                // If there is an error parsing the post, return null
                return null;
              }
            },
          )
          .where((post) => post != null)
          .cast<Post>()
          .where((post) => post.userId != userId)
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch following post: $err');
    }
  }

  Future<void> deletePost(Post post) async {
    throw UnimplementedError();
    // await client.post.deletePost(post);
  }
}
