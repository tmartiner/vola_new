part of 'login_screen.dart';

class _LoginPageOne extends StatelessWidget {
  const _LoginPageOne({required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
        ),
        Text(
          localizations.enter_email_message,
          style: textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 24.0),
        const _EmailInput(),
      ],
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
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
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
            context.read<LoginCubit>().emailChanged(controller.text);
          },
        );
      },
    );
  }
}
