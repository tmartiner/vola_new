import 'dart:async';

import 'package:auth_client/auth_client.dart';
import 'package:db_client/flutter.dart';
import 'package:file_upload_client/file_upload_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vola/firebase_options.dart';

import 'bootstrap.dart';
import 'repositories/repositories.dart';
import 'screens/app_screen.dart';

void main() async {
  unawaited(
    bootstrap(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        /// -- Overcome from transparent spaces at the bottom in iOS full Mode
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

        final dbClient = FirestoreDbClient();
        final authClient = FirebaseAuthClient();

        final fileUploadClient = FileUploadClient();

        final authRepository = AuthRepository(
          authClient: authClient,
          dbClient: dbClient,
        );

        final followerRepository = FollowerRepository(
          dbClient: dbClient,
        );

        final postRepository = PostRepository(
          dbClient: dbClient,
          fileUploadClient: fileUploadClient,
        );
        final userRepository = UserRepository(
          dbClient: dbClient,
          fileUploadClient: fileUploadClient,
        );

        return AppScreen(
          authRepository: authRepository,
          followerRepository: followerRepository,
          postRepository: postRepository,
          userRepository: userRepository,
        );
      },
    ),
  );
}
