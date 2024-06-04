import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';

import '../../repositories/post_repository.dart';
import '../../shared/widgets/modals/choose_audience_settings_modal.dart';
import '../../shared/widgets/modals/choose_reply_settings_modal.dart';
import '../../state/app/app_bloc.dart';
import '../../state/create_post/create_post_cubit.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(
        postRepository: context.read<PostRepository>(),
      ),
      child: const CreatePostView(),
    );
  }
}

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(AppLocalizations.of(context).draft),
          ),
          const SizedBox(width: 8.0),
          FilledButton(
            onPressed: () {
              context.read<CreatePostCubit>().createPost(
                    userId: user.id,
                    username: user.username ?? '',
                    profileImageUrl: user.profileImageUrl,
                  );
            },
            child: Text(AppLocalizations.of(context).share),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: BlocConsumer<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.submissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post created succesfully'),
              ),
            );
            context.goNamed('feed');
          }
          if (state.formStatus == FormStatus.invalid) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? '')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: (user.profileImageUrl != null)
                          ? NetworkImage(user.profileImageUrl!) as ImageProvider
                          : const AssetImage(
                              'assets/images/user_placeholder.png',
                            ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 8.0,
                              ),
                            ),
                            onPressed: () {
                              _chooseAudience(context);
                            },
                            icon: Text(
                              state.audience == PostAudienceSettings.everyone
                                  ? AppLocalizations.of(context).everyone
                                  : AppLocalizations.of(context).circle,
                            ),
                            label: const Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          TextFormField(
                            minLines: 3,
                            maxLines: 10,
                            maxLength: 4000,
                            onChanged: (String value) {
                              context
                                  .read<CreatePostCubit>()
                                  .captionChanged(value);
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .create_post_hint_text,
                              border: InputBorder.none,
                            ),
                          ),
                          (state.postImageUrl == null)
                              ? const SizedBox()
                              : Container(
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      state.postImageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 8.0,
                    ),
                  ),
                  onPressed: () {
                    _chooseWhoCanReply(context);
                  },
                  icon: Icon(
                    state.reply == PostReplySettings.everyone
                        ? Icons.public
                        : state.reply == PostReplySettings.follows
                            ? Icons.check_circle
                            : Icons.check_circle,
                    size: 16.0,
                  ),
                  label: Text(
                    state.reply == PostReplySettings.everyone
                        ? AppLocalizations.of(context).reply_settings_everyone
                        : state.reply == PostReplySettings.follows
                            ? AppLocalizations.of(context)
                                .reply_settings_follows
                            : AppLocalizations.of(context)
                                .reply_settings_mention_only,
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CreatePostCubit>().addPostPhoto();
                      },
                      icon: const Icon(Icons.image_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.gif_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.list_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.schedule),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _chooseWhoCanReply(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<CreatePostCubit>(),
          child: const ChooseReplySettingsModal(),
        );
      },
    );
  }

  Future<dynamic> _chooseAudience(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<CreatePostCubit>(),
          child: const ChooseAudienceSettingsModal(),
        );
      },
    );
  }
}
