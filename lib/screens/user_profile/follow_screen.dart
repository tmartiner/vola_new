import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/widgets/navbar.dart';
import '../../shared/widgets/sidebar.dart';
import '../../shared/widgets/user_preview_card.dart';
import '../../state/user_profile/user_profile_bloc.dart';

class FollowersAndFollowingScreen extends StatelessWidget {
  const FollowersAndFollowingScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.watch<UserProfileBloc>().state.user;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.status == UserProfileStatus.loading) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0.0,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            bottomNavigationBar: const Navbar(),
            drawer: const Sidebar(),
            appBar: AppBar(
              elevation: 0.0,
              leading: const BackButton(),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username ?? '',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).post_count(state.posts.length),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              centerTitle: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56.0),
                child: TabBar(
                  tabs: [
                    Tab(text: AppLocalizations.of(context).followers),
                    Tab(text: AppLocalizations.of(context).following),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.followers.length,
                    itemBuilder: (context, index) {
                      return UserPreviewCard(
                        user: state.followers[index],
                        follower: true,
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.following.length,
                    itemBuilder: (context, index) {
                      return UserPreviewCard(
                        user: state.following[index],
                        follower: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
