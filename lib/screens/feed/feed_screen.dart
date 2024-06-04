import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../repositories/post_repository.dart';
import '../../shared/widgets/post_widget.dart';
import '../../shared/widgets/sidebar.dart';
import '../../state/app/app_bloc.dart';
import '../../state/feed/feed_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AppBloc>().state.user?.id;
    return BlocProvider(
      create: (context) =>
          FeedBloc(postRepository: context.read<PostRepository>())
            ..add(FeedLoadEvent(userId: userId ?? '')),
      child: const FeedView(),
    );
  }
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const Sidebar(),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(user?.initials ?? ''),
                ),
              ),
            );
          }),
          title: Image.asset('assets/icons/app_icon.png', height: 50),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context).for_you),
                Tab(text: AppLocalizations.of(context).following),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed('create-post');
          },
          child: const Icon(Icons.post_add, color: Colors.white),
        ),
        body: const TabBarView(
          children: [
            _FeedForYouTab(),
            _FeedFollowingTab(),
          ],
        ),
      ),
    );
  }
}

class _FeedForYouTab extends StatelessWidget {
  const _FeedForYouTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state.status == FeedStatus.initial ||
            state.status == FeedStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == FeedStatus.loaded) {
          return ListView.builder(
            itemCount: state.forYouPosts.length,
            itemBuilder: (context, index) {
              final post = state.forYouPosts[index];
              return PostWidget(post: post);
            },
          );
        } else {
          return Center(child: Text(AppLocalizations.of(context).common_error));
        }
      },
    );
  }
}

class _FeedFollowingTab extends StatelessWidget {
  const _FeedFollowingTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state.status == FeedStatus.initial ||
            state.status == FeedStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == FeedStatus.loaded) {
          return ListView.builder(
            itemCount: state.followingPosts.length,
            itemBuilder: (context, index) {
              final post = state.followingPosts[index];
              return PostWidget(post: post);
            },
          );
        } else {
          return Center(child: Text(AppLocalizations.of(context).common_error));
        }
      },
    );
  }
}
