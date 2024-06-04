import 'package:uuid/uuid.dart';

import '../../common.dart';

class FakeDbClient implements DbClient {
  @override
  Future<String> add({
    required String entity,
    required Map<String, dynamic> data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final id = const Uuid().v4();
    _dataStore.putIfAbsent(entity, () => []);
    data['id'] = id;
    _dataStore[entity]!.add(data);
    return id;
  }

  @override
  Future<void> set({
    required String entity,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _dataStore.putIfAbsent(entity, () => []);
    data['id'] = id;
    final index = _dataStore[entity]!.indexWhere((doc) => doc['id'] == id);
    if (index != -1) {
      _dataStore[entity]![index] = data;
    } else {
      _dataStore[entity]!.add(data);
    }
  }

  @override
  Future<void> update({
    required String entity,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _dataStore.putIfAbsent(entity, () => []);
    final index = _dataStore[entity]!.indexWhere((doc) => doc['id'] == id);
    if (index != -1) {
      data.forEach((key, value) {
        // Check if the key exists and is a List in the document
        if (_dataStore[entity]![index][key] is List) {
          // Append the new value to the existing list
          List existingList = _dataStore[entity]![index][key];
          if (value is List) {
            // If the value is a list, extend the existing list with all new values
            existingList.addAll(value);
          } else {
            // If the value is a single item, add it to the existing list
            existingList.add(value);
          }
        } else {
          // If it's not a list, simply update the key with the new value
          _dataStore[entity]![index][key] = value;
        }
      });
    } else {
      throw Exception('Document not found');
    }
  }

  @override
  Future<void> deleteOneById({
    required String entity,
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    _dataStore.putIfAbsent(entity, () => []);
    // Check if it exists
    final index = _dataStore[entity]!.indexWhere((doc) => doc['id'] == id);
    if (index == -1) {
      throw Exception('Document not found');
    }
    _dataStore[entity]!.removeAt(index);
  }

  @override
  Future<DbRecord?> fetchOneById({
    required String entity,
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final data = _dataStore[entity]?.where((doc) {
      return doc['id'] == id;
    }).firstOrNull;

    return data != null ? DbRecord(id: id, data: data) : null;
  }

  @override
  Future<List<DbRecord>> fetchAll({required String entity}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _dataStore[entity]
            ?.map((doc) => DbRecord(id: doc['id'], data: doc))
            .toList() ??
        [];
  }

  @override
  Future<List<DbRecord>> fetchAllBy({
    required String entity,
    required Map<String, dynamic> filters,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    try {
      final collection = _dataStore[entity];
      if (collection == null) return [];

      List<Map<String, dynamic>> query;
      query = collection;

      filters.forEach(
        (key, value) {
          if (value is List<Map>) {
            for (var filter in value) {
              final queryType = filter['type'];
              final queryValue = filter['value'];
              query = _applyFilter(query, key, queryType, queryValue);
            }
          }
          if (value is Map) {
            final queryType = value['type'];
            final queryValue = value['value'];
            query = _applyFilter(query, key, queryType, queryValue);
            return;
          }
        },
      );

      return query.map((doc) => DbRecord(id: doc['id'], data: doc)).toList();
    } catch (err) {
      throw Exception('Error getting documents: $err');
    }
  }

  @override
  Stream<List<DbRecord>> streamAll({required String entity}) {
    final records = _dataStore[entity]
            ?.map((doc) => DbRecord(id: doc['id'], data: doc))
            .toList() ??
        [];

    return Stream.value(records);
  }

  @override
  Stream<List<DbRecord>> streamAllBy({
    required String entity,
    required Map<String, dynamic> filters,
  }) {
    final collection = _dataStore[entity];
    if (collection == null) return Stream.value([]);

    try {
      List<Map<String, dynamic>> query;
      query = collection;

      filters.forEach(
        (key, value) {
          if (value is List<Map>) {
            for (var filter in value) {
              final queryType = filter['type'];
              final queryValue = filter['value'];
              query = _applyFilter(query, key, queryType, queryValue);
            }
          }
          if (value is Map) {
            final queryType = value['type'];
            final queryValue = value['value'];
            query = _applyFilter(query, key, queryType, queryValue);
            return;
          }
        },
      );

      return Stream.value(
        query.map((doc) => DbRecord(id: doc['id'], data: doc)).toList(),
      );
    } catch (err) {
      throw Exception('Document not found: ${err.toString()}');
    }
  }

  @override
  Stream<DbRecord?> streamOneById({
    required String entity,
    required String id,
  }) {
    final data = _dataStore[entity]?.where((doc) {
      return doc['id'] == id;
    }).firstOrNull;

    final record = data != null ? DbRecord(id: id, data: data) : null;
    return Stream.value(record);
  }

  @override
  Future<List<DbRecord>> fetchAllFromBundle<T>({
    required String entity,
    required String bundleUrl,
  }) {
    return fetchAll(entity: entity);
  }

  @override
  Future<DbRecord?> fetchOneByIdFromBundle<T>({
    required String entity,
    required String id,
    required String bundleUrl,
  }) {
    return fetchOneById(entity: entity, id: id);
  }

  List<Map<String, dynamic>> _applyFilter(
    List<Map<String, dynamic>> query,
    String key,
    String queryType,
    dynamic queryValue,
  ) {
    switch (queryType) {
      case 'isGreaterThan':
        return query.where((doc) => doc[key] > queryValue).toList();
      case 'isGreaterThanOrEqualTo':
        return query.where((doc) => doc[key] >= queryValue).toList();
      case 'isLessThan':
        return query.where((doc) => doc[key] < queryValue).toList();
      case 'isLessThanOrEqualTo':
        return query.where((doc) => doc[key] <= queryValue).toList();
      case 'arrayContains':
        return query.where((doc) => doc[key].contains(queryValue)).toList();
      case 'isEqualTo':
        return query.where((doc) => doc[key] == queryValue).toList();
      case 'notEqualTo':
        return query.where((doc) => doc[key] != queryValue).toList();
      default:
        return query;
    }
  }

  Map<String, List<Map<String, dynamic>>> get dataStore => _dataStore;
  final Map<String, List<Map<String, dynamic>>> _dataStore = {
    'users': [
      {
        'id': 'user_1',
        'email': 'user1@example.com',
        'username': 'userone',
        'handle': '@user1',
        'bio': 'Bio of user 1',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'profileBannerUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'user_2',
        'email': 'user2@example.com',
        'username': 'usertwo',
        'handle': '@user2',
        'bio': 'Bio of user 2',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704462782000-5a2b96b9b1c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'profileBannerUrl':
            'https://images.unsplash.com/photo-1704462782000-5a2b96b9b1c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'user_3',
        'email': 'user3@example.com',
        'username': 'userthree',
        'handle': '@user3',
        'bio': 'Bio of user 3',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704402308313-ffd040169a75?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'profileBannerUrl':
            'https://images.unsplash.com/photo-1704402308313-ffd040169a75?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'user_4',
        'email': 'user4@example.com',
        'username': 'userfour',
        'handle': '@user4',
        'bio': 'Bio of user 4',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704110128700-edbe731be972?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'profileBannerUrl':
            'https://images.unsplash.com/photo-1704110128700-edbe731be972?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'user_5',
        'email': 'user5@example.com',
        'username': 'userfive',
        'handle': '@user5',
        'bio': 'Bio of user 5',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704381375059-b6861e025dd8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3',
        'profileBannerUrl':
            'https://images.unsplash.com/photo-1704381375059-b6861e025dd8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3',
      },
    ],
    'followers': [
      {
        'id': 'follower_1',
        'followerId': 'user_1',
        'followerUsername': 'userone',
        'followerHandle': '@user1',
        'followerProfileImageUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'followingId': 'user_2',
        'followingUsername': 'usertwo',
        'followingHandle': '@user2',
        'followingProfileImageUrl':
            'https://images.unsplash.com/photo-1704462782000-5a2b96b9b1c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3',
        'createdAt': '2024-01-10T10:10:10.000',
      },
      {
        'id': 'follower_2',
        'followerId': 'user_1',
        'followerUsername': 'userone',
        'followerHandle': '@user1',
        'followerProfileImageUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'followingId': 'user_3',
        'followingUsername': 'userthree',
        'followingHandle': '@user3',
        'followingProfileImageUrl':
            'https://images.unsplash.com/photo-1704402308313-ffd040169a75?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3',
        'createdAt': '2024-01-11T10:10:10.000',
      },
      {
        'id': 'follower_3',
        'followerId': 'user_1',
        'followerUsername': 'userone',
        'followerHandle': '@user1',
        'followerProfileImageUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'followingId': 'user_4',
        'followingUsername': 'userfour',
        'followingHandle': '@user4',
        'followingProfileImageUrl':
            'https://images.unsplash.com/photo-1704110128700-edbe731be972?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'createdAt': '2024-01-12T10:10:10.000',
      },
      {
        'id': 'follower_4',
        'followerId': 'user_3',
        'followerUsername': 'userthree',
        'followerHandle': '@user3',
        'followerProfileImageUrl':
            'https://images.unsplash.com/photo-1704402308313-ffd040169a75?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3',
        'followingId': 'user_1',
        'followingUsername': 'userone',
        'followingHandle': '@user1',
        'followingProfileImageUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'createdAt': '2024-01-13T10:10:10.000',
      },
    ],
    'posts': [
      {
        'id': 'post_1',
        'caption': 'First post caption',
        'imageUrl':
            'https://images.unsplash.com/photo-1704293763686-7070c47a1412?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'type': 0,
        'audience': 0,
        'reply': 0,
        'createdAt': '2024-01-01T10:10:10.000',
        'userId': 'user_1',
        'username': 'userone',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704721298056-6df695953129?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'post_2',
        'caption': 'Second post caption',
        'imageUrl':
            'https://images.unsplash.com/photo-1683009427479-c7e36bbb7bca?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'type': 0,
        'audience': 0,
        'reply': 0,
        'createdAt': '2024-01-01T10:10:50.000',
        'userId': 'user_2',
        'username': 'usertwo',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704462782000-5a2b96b9b1c1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'post_3',
        'caption': 'Third post caption',
        'imageUrl':
            'https://images.unsplash.com/photo-1704580104899-e99a78c4804b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'type': 0,
        'audience': 0,
        'reply': 0,
        'createdAt': '2024-01-01T10:11:10.000',
        'userId': 'user_3',
        'username': 'userthree',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704402308313-ffd040169a75?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'post_4',
        'caption': 'Fourth post caption',
        'imageUrl':
            'https://images.unsplash.com/photo-1704633785114-52104ce3d626?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'type': 0,
        'audience': 0,
        'reply': 0,
        'createdAt': '2024-01-01T12:10:10.000',
        'userId': 'user_4',
        'username': 'userfour',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704110128700-edbe731be972?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'id': 'post_5',
        'caption': 'Fifth post caption',
        'imageUrl':
            'https://plus.unsplash.com/premium_photo-1675864663002-c330710c6ba0?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'type': 0,
        'audience': 0,
        'reply': 0,
        'createdAt': '2024-01-02T10:10:10.000',
        'userId': 'user_5',
        'username': 'userfive',
        'profileImageUrl':
            'https://images.unsplash.com/photo-1704381375059-b6861e025dd8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
    ],
  };
}
