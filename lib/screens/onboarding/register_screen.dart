import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:models/models.dart';
import 'package:vola/shared/theme/colors.dart';
import 'package:vola/shared/utils/helpers/helper_functions.dart';

import '../../repositories/auth_repository.dart';
import '../../state/register/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = VHelperFunctions.isDarkMode(context);
    final localizations = AppLocalizations.of(context);
    final registerState = context.watch<RegisterCubit>().state;
    final textTheme = Theme.of(context).textTheme;

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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: isDark ? bgDarkGradient : bgLightGradient),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.36,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.create_your_account,
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const _EmailInput(),
                  const SizedBox(height: 12.0),
                  const _PasswordInput(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed:
                  (registerState.formStatus == FormStatus.submissionInProgress)
                      ? null
                      : () {
                          registerState.emailStatus == EmailStatus.valid &&
                                  registerState.passwordStatus ==
                                      PasswordStatus.valid
                              ? context.read<RegisterCubit>().register()
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

class _EmailInput extends StatefulWidget {
  const _EmailInput();

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: localizations.email,
            suffixIcon: state.emailStatus == EmailStatus.valid
                ? const Icon(Icons.check_circle, color: vPrimaryColor)
                : null,
            errorText: state.emailStatus == EmailStatus.invalid
                ? state.emailErrorMessage
                : null,
          ),
          onEditingComplete: () {
            context.read<RegisterCubit>().emailChanged(controller.text);
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          obscureText: true,
          decoration: InputDecoration(
            labelText: localizations.password,
            suffixIcon: state.passwordStatus == PasswordStatus.valid
                ? const Icon(Icons.check_circle, color: vPrimaryColor)
                : null,
            errorText: state.passwordStatus == PasswordStatus.invalid
                ? state.passwordErrorMessage
                : null,
          ),
          onEditingComplete: () {
            context.read<RegisterCubit>().passwordChanged(controller.text);
          },
        );
      },
    );
  }
}
