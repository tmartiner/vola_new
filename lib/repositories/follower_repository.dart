import 'package:db_client/common.dart';
import 'package:models/models.dart';

class FollowerRepository {
  final DbClient dbClient;

  const FollowerRepository({required this.dbClient});

  Future<List<Follower>> fetchFollowers(String userId) async {
    try {
      final followerFilter = Filter();
      followerFilter.addCondition(IsEqualTo(userId));

      final followersData = await dbClient.fetchAllBy(
        entity: 'followers',
        filters: {'followingId': followerFilter.toJson()['conditions']},
      );

      Filter();
      return followersData
          .map((follower) => Follower.fromJson(follower.data, id: follower.id))
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch followers: $err');
    }
  }

  Future<List<Follower>> fetchFollowing(String userId) async {
    try {
      final followingFilter = Filter();
      followingFilter.addCondition(IsEqualTo(userId));

      final followersData = await dbClient.fetchAllBy(
        entity: 'followers',
        filters: {
          'followerId': followingFilter.toJson()['conditions'],
        },
      );

      return followersData
          .map((follower) => Follower.fromJson(follower.data, id: follower.id))
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch followings: $err');
    }
  }

  Future<void> followUser(String followerId, String followingId) async {
    try {
      await dbClient.add(
        entity: 'followers',
        data: {
          'followerId': followerId,
          'followingId': followingId,
        },
      );
    } catch (err) {
      throw Exception('Failed to follow user: $err');
    }
  }

  Future<void> unfollowUser(String followerId, String followId) async {
    try {
      await dbClient.deleteOneById(
        entity: 'followers',
        id: followId,
      );
    } catch (err) {
      throw Exception('Failed to unfollow user: $err');
    }
  }
}
