import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostMoreActionsModal extends StatelessWidget {
  const PostMoreActionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.person_remove_alt_1_outlined,
              size: 30,
            ),
            title: Text(
              AppLocalizations.of(context).follow_user('username'),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.volume_off_outlined,
              size: 30,
            ),
            title: Text(
              AppLocalizations.of(context).mute_user('username'),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.code_outlined,
              size: 30,
            ),
            title: Text(
              AppLocalizations.of(context).embed_post,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56.0),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
