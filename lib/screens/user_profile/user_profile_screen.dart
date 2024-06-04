import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../repositories/follower_repository.dart';
import '../../repositories/post_repository.dart';
import '../../repositories/user_repository.dart';
import '../../shared/widgets/post_widget.dart';
import '../../state/user_profile/user_profile_bloc.dart';
import '../../shared/widgets/profile_images.dart';
import '../../shared/widgets/profile_information.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc(
        userRepository: context.read<UserRepository>(),
        followerRepository: context.read<FollowerRepository>(),
        postRepository: context.read<PostRepository>(),
      )..add(LoadUserProfileEvent(userId)),
      child: UserProfileView(userId: userId),
    );
  }
}

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.status == UserProfileStatus.loading) {
          return Scaffold(
            appBar: AppBar(elevation: 0.0),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return [
                  SliverAppBar(
                    forceElevated: innerBoxIsScrolled,
                    expandedHeight: 56.0,
                    elevation: 0.0,
                    leading: const BackButton(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user?.username ?? '',
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          localizations.post_count(state.posts.length),
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    centerTitle: false,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProfileImages(),
                            const ProfileInformation(),
                            TabBar(
                              tabs: [
                                Tab(
                                  icon: Text(localizations.posts),
                                ),
                                Tab(icon: Text(localizations.replies)),
                                Tab(icon: Text(localizations.media)),
                                Tab(icon: Text(localizations.likes)),
                              ],
                            )
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Tab 1
                  state.posts.isEmpty
                      ? Center(child: Text(localizations.no_posts_yet))
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return PostWidget(post: post);
                          },
                        ),
                  // Tab 2
                  Center(child: Text(localizations.not_implemented_yet)),
                  // Tab 3
                  Center(child: Text(localizations.not_implemented_yet)),
                  // Tab 4
                  Center(child: Text(localizations.not_implemented_yet)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
