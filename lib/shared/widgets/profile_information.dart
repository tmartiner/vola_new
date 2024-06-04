import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../state/app/app_bloc.dart';
import '../../state/user_profile/user_profile_bloc.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final myUserId = context.watch<AppBloc>().state.user?.id ?? '';

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        final isMe = myUserId == state.user?.id;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isMe
                        ? OutlinedButton(
                            onPressed: () {
                              context.pushNamed(
                                'edit-user-profile',
                                extra: context.read<UserProfileBloc>(),
                                pathParameters: {'userId': state.user!.id},
                              );
                            },
                            child:
                                Text(AppLocalizations.of(context).edit_profile),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Text(
                state.user?.username ?? '',
                style: textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                state.user?.handle ?? '',
                style: textTheme.bodyLarge!.copyWith(
                  color: Colors.white.withAlpha(150),
                ),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  context.pushNamed(
                    'followers-and-following',
                    extra: context.read<UserProfileBloc>(),
                    pathParameters: {'userId': state.user!.id},
                  );
                },
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${state.user?.followingCount} ',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context).following,
                            style: textTheme.bodyLarge!.copyWith(
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${state.user?.followerCount} ',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context).followers,
                            style: textTheme.bodyLarge!.copyWith(
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
