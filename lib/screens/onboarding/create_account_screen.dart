import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:models/models.dart';
import 'package:vola/shared/theme/colors.dart';
import 'package:vola/shared/utils/helpers/helper_functions.dart';

import '../../repositories/user_repository.dart';
import '../../shared/utils/datetime_extensions.dart';
import '../../state/app/app_bloc.dart';
import '../../state/create_account/create_account_cubit.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: const CreateAccountView(),
    );
  }
}

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late CreateAccountState? previousState;

  @override
  Widget build(BuildContext context) {
    final isDark = VHelperFunctions.isDarkMode(context);
    final localizations = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final createAccountState = context.watch<CreateAccountCubit>().state;
    final user = context.read<AppBloc>().state.user;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SvgPicture.asset(
          "assets/icons/logo_crow_final_bold.svg",
          colorFilter: const ColorFilter.mode(vTertiaryColor, BlendMode.srcIn),
          height: 50,
        ),
      ),
      body: BlocListener<CreateAccountCubit, CreateAccountState>(
        listenWhen: (previous, current) {
          return previous.profileBannerStatus != current.profileBannerStatus ||
              previous.profileImageStatus != current.profileImageStatus ||
              previous.formStatus != current.formStatus;
        },
        listener: (context, state) {
          if (state.formStatus == FormStatus.submissionSuccess) {
            context.read<AppBloc>().add(const AppUserRefreshRequested());
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(localizations.succsess),
                ),
              );
          }
          if (state.formStatus == FormStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(localizations.common_error),
                ),
              );
          }
          if (state.profileBannerStatus == ProfileBannerStatus.loaded &&
              (previousState == null ||
                  previousState?.profileBannerStatus !=
                      ProfileBannerStatus.loaded)) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(localizations.banner_is_uploadet),
                ),
              );
          }
          if (state.profileImageStatus == ProfileImageStatus.loaded &&
              (previousState == null ||
                  previousState?.profileImageStatus !=
                      ProfileImageStatus.loaded)) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(localizations.picture_is_uploadet),
                ),
              );
          }
          // Update the previous state
          previousState = state;
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: isDark ? bgDarkGradient : bgLightGradient),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.complete_your_profile,
                      style: textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                        children: [
                      {
                        'index': 0,
                        'text': localizations.upload_a_picture,
                        'icon': Icons.image_outlined,
                        'onPressed': () {
                          context.read<CreateAccountCubit>().addProfilePhoto();
                        },
                      },
                      {
                        'index': 1,
                        'text': localizations.upload_a_banner,
                        'icon': Icons.image_search_outlined,
                        'onPressed': () {
                          context.read<CreateAccountCubit>().addProfileBanner();
                        },
                      }
                    ].map((data) {
                      return Expanded(
                        child: Container(
                          height: 100,
                          margin: (data['index'] == 0)
                              ? const EdgeInsets.only(right: 16.0)
                              : null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: colorScheme.tertiaryContainer,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8.0),
                              Text(
                                data['text'] as String,
                                style: textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: data['onPressed'] as VoidCallback,
                                icon: Icon(data['icon'] as IconData),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList()),
                    const SizedBox(
                      height: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 40.0),
                            _NameInput(),
                            SizedBox(height: 12.0),
                            _UserName(),
                            SizedBox(height: 12.0),
                            _DateOfBirthInput(),
                            SizedBox(height: 12.0),
                            _BioInput(),
                            SizedBox(height: 194.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: (createAccountState.formStatus ==
                      FormStatus.submissionInProgress)
                  ? null
                  : () {
                      (user != null && createAccountState.formComplete)
                          ? context.read<CreateAccountCubit>().updateUser(user)
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  localizations.fill_all_the_fields,
                                ),
                              ),
                            );
                    },
              label: const Icon(Icons.save_outlined),
              icon: Text(localizations.save),
            ),
          ],
        ),
      ),
    );
  }
}

class _BioInput extends StatefulWidget {
  const _BioInput();

  @override
  State<_BioInput> createState() => _BioInputState();
}

class _BioInputState extends State<_BioInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          maxLines: 4,
          maxLength: 180,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: localizations.bio,
            labelStyle: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurface,
            ),
            suffixIcon: state.bioStatus == BioStatus.valid
                ? const Icon(Icons.check_circle, color: vPrimaryColor)
                : null,
            errorText: state.bioStatus == BioStatus.invalid
                ? state.bioErrorMessage
                : null,
          ),
          onChanged: (value) {
            context.read<CreateAccountCubit>().bioChanged(controller.text);
          },
        );
      },
    );
  }
}

class _UserName extends StatefulWidget {
  const _UserName();

  @override
  State<_UserName> createState() => _UserNameInputState();
}

class _UserNameInputState extends State<_UserName> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: localizations.username,
            labelStyle: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurface,
            ),
            suffixIcon: state.usernameStatus == UserNameStatus.valid
                ? const Icon(Icons.check_circle, color: vPrimaryColor)
                : null,
            errorText: state.usernameStatus == UserNameStatus.invalid
                ? state.usernameErrorMessage
                : null,
          ),
          onEditingComplete: () {
            context.read<CreateAccountCubit>().usernameChanged(controller.text);
          },
        );
      },
    );
  }
}

class _DateOfBirthInput extends StatefulWidget {
  const _DateOfBirthInput();

  @override
  State<_DateOfBirthInput> createState() => _DateOfBirthInputState();
}

class _DateOfBirthInputState extends State<_DateOfBirthInput> {
  final controller = TextEditingController();
  var date = DateTime(2024, 01, 01);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _selectDate(context);
          },
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).date_of_birth,
            suffixIcon: state.dateOfBirthStatus == DateOfBirthStatus.valid
                ? const Icon(Icons.check_circle, color: vPrimaryColor)
                : null,
            errorText: state.dateOfBirthStatus == DateOfBirthStatus.invalid
                ? state.dateOfBirthErrorMessage
                : null,
          ),
        );
      },
    );
  }

  _selectDate(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await _showCupertinoDatePicker(context);
    } else {
      await _showMaterialDatePicker(context);
    }
  }

  _showCupertinoDatePicker(BuildContext context) async {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) {
        return Container(
          height: 220,
          padding: const EdgeInsets.only(top: 8.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: date,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              showDayOfWeek: true,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  date = newDate;
                  controller.text = newDate.toCustomFormat();
                });
                context.read<CreateAccountCubit>().dateOfBirthChanged(newDate);
              },
            ),
          ),
        );
      },
    ).then((value) => null);
  }

  _showMaterialDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != date) {
        setState(() {
          date = pickedDate;
          controller.text = pickedDate.toCustomFormat();
        });
        context.read<CreateAccountCubit>().dateOfBirthChanged(pickedDate);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _NameInput extends StatefulWidget {
  const _NameInput();

  @override
  State<_NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: localizations.name,
            suffixIcon: state.nameStatus == NameStatus.valid
                ? const Icon(Icons.check_circle, color: vPrimaryColor)
                : null,
            errorText: state.nameStatus == NameStatus.invalid
                ? state.nameErrorMessage
                : null,
          ),
          onEditingComplete: () {
            context.read<CreateAccountCubit>().nameChanged(controller.text);
          },
        );
      },
    );
  }
}
