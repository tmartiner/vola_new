import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vola/shared/theme/colors.dart';

import '../../state/app/app_bloc.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.watch<AppBloc>().state.user;

    return Drawer(
      elevation: 3,
      width: MediaQuery.of(context).size.width * 0.8,
      shadowColor: vSecondaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 240,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: (user?.profileImageUrl != null)
                            ? CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(user!.profileImageUrl!),
                              )
                            : const CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(
                                  'assets/images/user_placeholder.png',
                                ),
                              ),
                      ),
                      IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    user?.username ?? '',
                    style: textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user?.handle ?? '',
                    style: textTheme.titleMedium!.copyWith(
                      color: Colors.white.withAlpha(150),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${user?.followingCount} ',
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Following',
                              style: textTheme.titleMedium!.copyWith(
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
                              text: '${user?.followerCount} ',
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Followers',
                              style: textTheme.titleMedium!.copyWith(
                                color: Colors.white.withAlpha(150),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(
              'Profile',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              context.pushNamed(
                'user-profile',
                pathParameters: {
                  'userId': context.read<AppBloc>().state.user!.id,
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium_outlined),
            title: Text(
              'Premium',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: Text(
              'Lists',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: Text(
              'Bookmarks',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ExpansionTile(
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            title: Text(
              'Settings and support',
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(
                  'Settings and privacy',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.data_saver_off_outlined),
                title: Text(
                  'Data saver',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: Text(
                  'Log out',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  context.read<AppBloc>().add(const AppLogoutRequested());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
