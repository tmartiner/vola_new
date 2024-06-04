import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vola/shared/theme/colors.dart';
import 'package:vola/shared/utils/helpers/helper_functions.dart';

import '../../repositories/auth_repository.dart';
import '../../state/login/login_cubit.dart';

part '_login_page_1.dart';
part '_login_page_2.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int pageIndex = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginCubit>().state;
    final isDark = VHelperFunctions.isDarkMode(context);

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
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.invalid ||
              state.formStatus == FormStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(8.0),
                  content: Text(state.formErrorMessage ?? ''),
                ),
              );
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: isDark ? bgDarkGradient : bgLightGradient),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          pageIndex = value;
                        });
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _LoginPageOne(controller: controller),
                        _LoginPageTwo(controller: controller),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pageIndex == 0
                ? const SizedBox(width: 48.0)
                : OutlinedButton.icon(
                    onPressed: () {
                      controller.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    },
                    label: Text(AppLocalizations.of(context).back),
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
            (pageIndex == 0)
                ? FilledButton.icon(
                    onPressed: () {
                      (loginState.emailStatus == EmailStatus.valid)
                          ? controller.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            )
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context).fill_your_email,
                                ),
                              ),
                            );
                    },
                    label: Text(AppLocalizations.of(context).next),
                    icon: const Icon(Icons.chevron_right_rounded),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
