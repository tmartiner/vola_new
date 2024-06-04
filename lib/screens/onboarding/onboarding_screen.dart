import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vola/shared/theme/colors.dart';
import 'package:vola/shared/utils/helpers/helper_functions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = VHelperFunctions.isDarkMode(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0).copyWith(bottom: 32.0),
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    localizations.introduct_yourself,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const Spacer(),
                  // LoginWithApple(onLogin: () {}),
                  // const SizedBox(height: 16.0),
                  // LoginWithGoogle(onLogin: () {}),
                  // const SizedBox(height: 16.0),
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     const Divider(),
                  //     Container(
                  //       padding: const EdgeInsets.all(8.0),
                  //       color: colorScheme.surface,
                  //       child: Text(
                  //         localizations.common_or_all_caps,
                  //         style: textTheme.bodySmall,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 16.0),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      minimumSize: const Size.fromHeight(48.0),
                    ),
                    onPressed: () => context.pushNamed('register'),
                    child: Text(
                      localizations.create_your_account,
                      style: textTheme.labelLarge!.copyWith(
                        color: colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      localizations.agreee_to_terms,
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.already_have_an_account,
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed('login'),
                        child: Text(localizations.login),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class LoginWithApple extends StatelessWidget {
//   final VoidCallback onLogin;

//   const LoginWithApple({super.key, required this.onLogin});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final localizations = AppLocalizations.of(context);
//     return FilledButton(
//       style: FilledButton.styleFrom(
//         backgroundColor: colorScheme.inverseSurface,
//         minimumSize: const Size.fromHeight(48.0),
//       ),
//       onPressed: onLogin,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             left: 48.0,
//             child: Image.asset(
//               'assets/images/apple_logo.png',
//               height: 20,
//               width: 20,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Center(
//             child: Text(
//               localizations.continue_with_apple,
//               style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                     color: colorScheme.onInverseSurface,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LoginWithGoogle extends StatelessWidget {
//   final VoidCallback onLogin;

//   const LoginWithGoogle({super.key, required this.onLogin});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final localizations = AppLocalizations.of(context);
//     return FilledButton(
//       style: FilledButton.styleFrom(
//         backgroundColor: colorScheme.inverseSurface,
//         minimumSize: const Size.fromHeight(48.0),
//       ),
//       onPressed: onLogin,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             left: 48.0,
//             child: Image.asset(
//               'assets/images/google_logo.png',
//               height: 20,
//               width: 20,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Center(
//             child: Text(
//               localizations.continue_with_google,
//               style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                     color: colorScheme.onInverseSurface,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );
//  }
//}
