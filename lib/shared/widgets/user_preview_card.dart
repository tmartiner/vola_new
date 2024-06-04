import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';

class UserPreviewCard extends StatelessWidget {
  const UserPreviewCard({
    super.key,
    required this.user,
    required this.follower,
  });

  final Follower user;
  final bool follower;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final userId = follower ? user.followerId : user.followingId;
    final username = follower ? user.followerUsername : user.followingUsername;
    final handle = follower ? user.followerHandle : user.followingHandle;
    final profileImageUrl =
        follower ? user.followerProfileImageUrl : user.followingProfileImageUrl;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.pushNamed(
                'user-profile',
                pathParameters: {'userId': userId},
              );
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: (profileImageUrl != null)
                      ? Image.network(
                          profileImageUrl,
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/user_placeholder.png',
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      handle,
                      style: textTheme.bodyMedium!
                          .copyWith(color: Colors.white.withAlpha(100)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              follower
                  ? FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(80, 32),
                      ),
                      onPressed: () {},
                      child: const Text('Follow'),
                    )
                  : const Chip(label: Text('Following')),
              const SizedBox(width: 4.0),
              follower
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        _followerActions(
                          context,
                          userId,
                          username,
                        );
                      },
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.more_horiz),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> _followerActions(
    BuildContext context,
    String userId,
    String username,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.volume_off_outlined),
                title: Text('Mute $username'),
                onTap: () {
                  context.pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.block_outlined),
                title: Text('Block $username'),
                onTap: () {
                  context.pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.report),
                title: Text('Report $username'),
                onTap: () {
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
