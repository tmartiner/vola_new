import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../l10n/l10n.dart';
import '../repositories/repositories.dart';
import '../shared/navigation/app_router.dart';
import '../shared/theme/app_theme.dart';
import '../state/app/app_bloc.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.authRepository,
    required this.followerRepository,
    required this.postRepository,
    required this.userRepository,
  });

  final AuthRepository authRepository;
  final FollowerRepository followerRepository;
  final PostRepository postRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: followerRepository),
        RepositoryProvider.value(value: postRepository),
        RepositoryProvider.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => AppBloc(
              authRepository: authRepository,
              userRepository: userRepository,
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Vola',
            theme:
                AppTheme().themeDataLight(isDarkTheme: false, context: context),
            darkTheme:
                AppTheme().themeDataDark(isDarkTheme: true, context: context),
            themeMode: ThemeMode.system,
            routerConfig: AppRouter(appBloc: context.read<AppBloc>()).router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        }),
      ),
    );
  }
}
