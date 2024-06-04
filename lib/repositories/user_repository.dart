import 'package:db_client/common.dart';
import 'package:file_upload_client/file_upload_client.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class UserNotFoundException implements Exception {
  final String userId;

  UserNotFoundException(this.userId);

  @override
  String toString() => 'UserNotFoundException: No user found with id $userId';
}

class UserRepository {
  final DbClient dbClient;
  final FileUploadClient fileUploadClient;

  const UserRepository({
    required this.dbClient,
    required this.fileUploadClient,
  });

  Future<User?> createMe({required Map<String, dynamic> data}) async {
    try {
      await dbClient.set(
        entity: 'users',
        data: data,
        id: data['id'],
      );
      return User.fromJson(data, id: data['id']);
    } catch (err) {
      throw Exception('Failed to create the user: $err');
    }
  }

  Future<User?> fetchMe({required String userId}) async {
    try {
      var userDataFuture = dbClient.fetchOneById(
        entity: 'users',
        id: userId,
      );

      final followerFilter = Filter();
      followerFilter.addCondition(IsEqualTo(userId));

      final userFollowingsCountFuture = dbClient.fetchAllBy(
        entity: 'followers',
        filters: {'followerId': followerFilter.toJson()['conditions']},
      );

      final followingFilter = Filter();
      followingFilter.addCondition(IsEqualTo(userId));

      final userFollowersCountFuture = dbClient.fetchAllBy(
        entity: 'followers',
        filters: {'followingId': followingFilter.toJson()['conditions']},
      );

      final results = await Future.wait([
        userDataFuture,
        userFollowingsCountFuture,
        userFollowersCountFuture,
      ]);

      final userData = results[0] as DbRecord?;

      if (userData == null) {
        throw UserNotFoundException(userId);
      }

      final user = User.fromJson(userData.data, id: userData.id);

      return user.copyWith(
        followingCount: (results[1] as List<DbRecord>).length,
        followerCount: (results[2] as List<DbRecord>).length,
      );
    } on UserNotFoundException {
      rethrow;
    } catch (err) {
      throw Exception('Failed to fetch the user: $err');
    }
  }

  Future<void> updateMe(User user) async {
    debugPrint('Sending a request to update the user: ${user.id}');
    try {
      await dbClient.update(
        entity: 'users',
        id: user.id,
        data: user.toJson(),
      );
    } catch (err) {
      throw Exception('Failed to update the user: $err');
    }
  }

  Future<bool> deleteMe({required String userId}) async {
    debugPrint('Sending a request to delete the user.');
    try {
      await dbClient.deleteOneById(entity: 'users', id: userId);
      return true;
    } catch (err) {
      throw Exception('Failed to delete the user');
    }
  }

  Future<User> fetchUser(String userId) async {
    try {
      final userData = await dbClient.fetchOneById(
        entity: 'users',
        id: userId,
      );

      if (userData == null) {
        throw UserNotFoundException(userId);
      }
      return User.fromJson(userData.data, id: userData.id);
    } catch (err) {
      throw Exception('Failed to fetch user: $err');
    }
  }

  Future<String?> addUserProfilePhoto() async {
    try {
      final filePath = await fileUploadClient.pickImage();
      if (filePath == null) {
        return null;
      } else {
        final downloadUrl = await fileUploadClient.uploadImage(filePath);
        return downloadUrl;
      }
    } catch (err) {
      throw Exception('Failed to add user profile photo: $err');
    }
  }

  Future<String?> addUserProfileBanner() async {
    try {
      final filePath = await fileUploadClient.pickImage();
      if (filePath == null) {
        return null;
      } else {
        final downloadUrl = await fileUploadClient.uploadImage(filePath);
        return downloadUrl;
      }
    } catch (err) {
      throw Exception('Failed to add user profile banner: $err');
    }
  }
}
