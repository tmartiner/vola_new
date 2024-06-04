import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';

import '../utils/datetime_extensions.dart';
import 'post_more_actions_modal.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withAlpha(200),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post.profileImageUrl == null
                  ? const CircleAvatar(child: Icon(Icons.person))
                  : CircleAvatar(
                      backgroundImage: NetworkImage(post.profileImageUrl!),
                    ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              'user-profile',
                              pathParameters: {'userId': post.userId},
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                post.username,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8.0),
                              const Icon(
                                Icons.verified,
                                size: 16,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                '@handle - ${post.createdAt?.toCustomDateTimeFormat()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white.withAlpha(100)),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const PostMoreActionsModal();
                              },
                            );
                          },
                          customBorder: const CircleBorder(),
                          child: const Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(post.caption),
                    const SizedBox(height: 8.0),
                    (post.imageUrl == null)
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.white.withAlpha(200),
                                width: 0.5,
                              ),
                            ),
                            child: Image.network(post.imageUrl!),
                          ),
                    const SizedBox(height: 8.0),
                    // TODO: Implement post actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.comment_outlined),
                            SizedBox(width: 4.0),
                            Text('6'),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.compare_arrows_outlined),
                            SizedBox(width: 4.0),
                            Text('6'),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.favorite_outline),
                            SizedBox(width: 4.0),
                            Text('6'),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.stacked_bar_chart_outlined),
                            SizedBox(width: 4.0),
                            Text('6'),
                          ],
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {},
                          icon: const Icon(Icons.ios_share_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
