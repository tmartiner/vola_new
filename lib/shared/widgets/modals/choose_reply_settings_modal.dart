import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';

import '../../../state/create_post/create_post_cubit.dart';

class ChooseReplySettingsModal extends StatelessWidget {
  const ChooseReplySettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Who can reply?',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Choose who can reply to this post. Anyone mentioned can always reply.',
              ),
              const SizedBox(height: 16.0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  child: Icon(Icons.public),
                ),
                title: const Text('Everyone'),
                trailing: state.reply == PostReplySettings.everyone
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  context
                      .read<CreatePostCubit>()
                      .replyChanged(PostReplySettings.everyone);
                  context.pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  child: Icon(Icons.people_alt),
                ),
                title: const Text('People you follow'),
                trailing: state.reply == PostReplySettings.follows
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  context
                      .read<CreatePostCubit>()
                      .replyChanged(PostReplySettings.follows);
                  context.pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  child: Icon(Icons.monetization_on),
                ),
                title: const Text('Only people you mention'),
                trailing: state.reply == PostReplySettings.mentions
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  context
                      .read<CreatePostCubit>()
                      .replyChanged(PostReplySettings.mentions);
                  context.pop();
                },
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
