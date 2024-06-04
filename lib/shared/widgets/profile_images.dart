import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/app/app_bloc.dart';
import '../../state/user_profile/user_profile_bloc.dart';

class ProfileImages extends StatelessWidget {
  const ProfileImages({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final myUserId = context.watch<AppBloc>().state.user?.id ?? '';

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        final isMe = myUserId == state.user?.id;
        debugPrint("${state.user?.profileImageUrl == ''}");

        return GestureDetector(
          onTap: isMe
              ? () {
                  context.read<UserProfileBloc>().add(AddProfileBannerEvent());
                }
              : null,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              image: (state.user?.profileBannerUrl == null ||
                      state.user?.profileBannerUrl == '')
                  ? null
                  : DecorationImage(
                      image: NetworkImage(state.user!.profileBannerUrl!),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Transform.translate(
              offset: const Offset(0, 60),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0.0,
                    left: 16.0,
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: GestureDetector(
                          onTap: isMe
                              ? () {
                                  context
                                      .read<UserProfileBloc>()
                                      .add(AddProfilePhotoEvent());
                                }
                              : null,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                (state.user?.profileImageUrl != null &&
                                        state.user?.profileImageUrl != '')
                                    ? NetworkImage(state.user!.profileImageUrl!)
                                        as ImageProvider<Object>
                                    : const AssetImage(
                                        'assets/images/user_placeholder.png',
                                      ),
                          ),
                        ),
                      ),
                    ),
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
