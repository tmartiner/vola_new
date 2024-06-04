import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vola/screens/onboarding/create_account_screen.dart';

import '../../screens/feed/create_post_screen.dart';
import '../../screens/feed/feed_screen.dart';
import '../../screens/onboarding/login_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/onboarding/register_screen.dart';
import '../../screens/user_profile/edit_user_profile_screen.dart';
import '../../screens/user_profile/follow_screen.dart';
import '../../screens/user_profile/user_profile_screen.dart';
import '../../state/app/app_bloc.dart';
import '../../state/user_profile/user_profile_bloc.dart';
import 'go_router_refresh_stream.dart';

class AppRouter {
  final AppBloc appBloc;
  AppRouter({required this.appBloc});

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const FeedScreen();
        },
        routes: [
          GoRoute(
            name: 'create-post',
            path: 'create-post',
            builder: (BuildContext context, GoRouterState state) {
              return const CreatePostScreen();
            },
          ),
        ],
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
        routes: [
          GoRoute(
            name: 'login',
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            name: 'register',
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterScreen();
            },
          ),
          GoRoute(
            name: 'create-account',
            path: 'create-account',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateAccountScreen();
            },
          ),
        ],
      ),
      GoRoute(
        name: 'user-profile',
        path: '/user-profile/:userId',
        builder: (BuildContext context, GoRouterState state) {
          return UserProfileScreen(userId: state.pathParameters['userId']!);
        },
        routes: [
          GoRoute(
            name: 'edit-user-profile',
            path: 'edit',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider.value(
                value: state.extra! as UserProfileBloc,
                child: EditUserProfileScreen(
                  userId: state.pathParameters['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            name: 'followers-and-following',
            path: 'follow',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider.value(
                value: state.extra! as UserProfileBloc,
                child: FollowersAndFollowingScreen(
                  userId: state.pathParameters['userId']!,
                ),
              );
            },
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final user = appBloc.state.user;
      final isAuthenticated = appBloc.state.status == AppStatus.authenticated;
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isLogin = state.matchedLocation == '/onboarding/login';
      final isRegister = state.matchedLocation == '/onboarding/register';
      final isCreateAccount =
          state.matchedLocation == '/onboarding/create-account';

      if (isAuthenticated && isOnboarding && user?.username != null) {
        return '/';
      }
      if (isAuthenticated && isCreateAccount && user?.username != null) {
        return '/';
      }
      if (isAuthenticated && user?.username == null) {
        return '/onboarding/create-account';
      }
      if (!isAuthenticated && isLogin) {
        return '/onboarding/login';
      }
      if (!isAuthenticated && isRegister) {
        return '/onboarding/register';
      }

      if (!isAuthenticated) {
        return '/onboarding';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
  );
}
