part of 'login_screen.dart';

class _LoginPageTwo extends StatelessWidget {
  const _LoginPageTwo({required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
        ),
        Text(
          localizations.enter_password,
          style: textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 24.0),
        TextFormField(
          readOnly: true,
          initialValue: state.email!.value,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            labelText: localizations.email,
            suffixIcon: const Icon(Icons.check_circle, color: vPrimaryColor),
          ),
        ),
        const SizedBox(height: 12.0),
        const _PasswordInput(),
        const Spacer(flex: 1),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            minimumSize: const Size.fromHeight(48.0),
          ),
          onPressed: (state.formStatus == FormStatus.submissionInProgress)
              ? null
              : () => context.read<LoginCubit>().login(),
          child: Text(
            localizations.login,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: colorScheme.onInverseSurface,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(48.0),
          ),
          onPressed: () {},
          child: Text(AppLocalizations.of(context).forgot_password),
        ),
        const Spacer(flex: 2),
      ],
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
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.normal,
          ),
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
            context.read<LoginCubit>().passwordChanged(controller.text);
          },
        );
      },
    );
  }
}
