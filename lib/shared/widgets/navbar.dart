import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 50,
      indicatorColor: Colors.transparent,
      destinations: [
        NavigationDestination(
          selectedIcon: const Icon(Icons.home),
          icon: const Icon(Icons.home_outlined),
          label: AppLocalizations.of(context).home,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.search),
          icon: const Icon(Icons.search_outlined),
          label: AppLocalizations.of(context).search,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.notifications),
          icon: const Icon(Icons.notifications_outlined),
          label: AppLocalizations.of(context).notifications,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.inbox),
          icon: const Icon(Icons.inbox_outlined),
          label: AppLocalizations.of(context).inbox,
        ),
      ],
    );
  }
}
