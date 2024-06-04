import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../state/user_profile/user_profile_bloc.dart';
import '../../shared/widgets/profile_images.dart';

class EditUserProfileScreen extends StatelessWidget {
  const EditUserProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: const BackButton(),
        title: Text(
          AppLocalizations.of(context).edit_profile,
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          FilledButton(
            onPressed: () {
              context.read<UserProfileBloc>().add(UpdateUserProfileEvent());
              context.pop();
            },
            child: Text(AppLocalizations.of(context).save),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImages(),
            SizedBox(height: 60.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _NameInput(),
                  SizedBox(height: 8.0),
                  _UserNameInput(),
                  SizedBox(height: 8.0),
                  _BioInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          initialValue: state.user?.name,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
            labelStyle: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          onChanged: (String value) {
            context.read<UserProfileBloc>().add(EditNameEvent(name: value));
          },
        );
      },
    );
  }
}

class _BioInput extends StatelessWidget {
  const _BioInput();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          initialValue: state.user?.bio,
          minLines: 1,
          maxLines: 10,
          maxLength: 4000,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).bio,
            labelStyle: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          onChanged: (value) {
            context.read<UserProfileBloc>().add(EditBioEvent(bio: value));
          },
        );
      },
    );
  }
}

class _UserNameInput extends StatelessWidget {
  const _UserNameInput();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          initialValue: state.user?.username,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).username,
            labelStyle: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          onChanged: (String value) {
            context
                .read<UserProfileBloc>()
                .add(EditUserNameEvent(username: value));
          },
        );
      },
    );
  }
}
