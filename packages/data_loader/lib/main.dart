import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:db_client/common.dart';
import 'package:db_client/flutter.dart';
import 'package:models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "...",
        authDomain: "...",
        projectId: "...",
        storageBucket: "...",
        messagingSenderId: "...",
        appId: "..."),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final firestore = FirestoreDbClient();
  final sampleData = FakeDbClient().dataStore;

  @override
  void initState() {
    loadSampleUsers();
    loadSamplePosts();
    loadSampleFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void loadSampleUsers() {
    final users = sampleData['users'];

    if (users != null) {
      for (final user in users) {
        firestore.set(
          entity: 'users',
          data: User.fromJson(user).toJson(),
          id: user['id'],
        );
      }
    }
  }

  void loadSamplePosts() {
    final posts = sampleData['posts'];

    if (posts != null) {
      for (final post in posts) {
        firestore.set(
          entity: 'posts',
          data: Post.fromJson(post).toJson(),
          id: post['id'],
        );
      }
    }
  }

  void loadSampleFollowers() {
    final followers = sampleData['followers'];

    if (followers != null) {
      for (final product in followers) {
        firestore.set(
          entity: 'followers',
          data: Follower.fromJson(product).toJson(),
          id: product['id'],
        );
      }
    }
  }
}
