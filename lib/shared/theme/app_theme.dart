import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme();

  ThemeData themeDataLight(
      {required bool isDarkTheme, required BuildContext context}) {
    return FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xff2da6bf),
        primaryContainer: Color(0xffe5f5f8),
        secondary: Color(0xff12424c),
        secondaryContainer: Color(0xfffff6f3),
        tertiary: Color(0xff92ccde),
        tertiaryContainer: Color(0xffffffff),
        appBarColor: Color(0xfffff6f3),
        error: Color(0xffb00020),
      ),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 6,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 8,
        blendOnColors: false,
        blendTextTheme: true,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.primary,
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 31,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorFocusedBorderWidth: 1.0,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.tertiary,
        popupMenuRadius: 8.0,
        popupMenuElevation: 3.0,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        drawerIndicatorRadius: 12.0,
        drawerIndicatorSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
        menuRadius: 8.0,
        menuElevation: 3.0,
        menuBarRadius: 0.0,
        menuBarElevation: 2.0,
        menuBarShadowColor: Color(0x00000000),
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorOpacity: 1.00,
        navigationBarIndicatorRadius: 12.0,
        navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
        navigationRailMutedUnselectedLabel: false,
        navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationRailMutedUnselectedIcon: false,
        navigationRailIndicatorSchemeColor: SchemeColor.primary,
        navigationRailIndicatorOpacity: 1.00,
        navigationRailIndicatorRadius: 12.0,
        navigationRailBackgroundSchemeColor: SchemeColor.surface,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      fontFamily: GoogleFonts.varelaRound().fontFamily,
    );
  }

  ThemeData themeDataDark(
      {required bool isDarkTheme, required BuildContext context}) {
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: Color(0xff2da6bf),
        primaryContainer: Color(0xff01252d),
        secondary: Color(0xff12424c),
        secondaryContainer: Color(0xff231a17),
        tertiary: Color(0xfff0dcd6),
        tertiaryContainer: Color(0xff364446),
        appBarColor: Color(0xff231a17),
        error: Color(0xffcf6679),
      ),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 2,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendTextTheme: true,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.primary,
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 43,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorFocusedBorderWidth: 1.0,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        fabUseShape: true,
        fabAlwaysCircular: true,
        fabSchemeColor: SchemeColor.tertiary,
        popupMenuRadius: 8.0,
        popupMenuElevation: 3.0,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        drawerIndicatorRadius: 12.0,
        drawerIndicatorSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
        menuRadius: 8.0,
        menuElevation: 3.0,
        menuBarRadius: 0.0,
        menuBarElevation: 2.0,
        menuBarShadowColor: Color(0x00000000),
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorOpacity: 1.00,
        navigationBarIndicatorRadius: 12.0,
        navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
        navigationRailMutedUnselectedLabel: false,
        navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationRailMutedUnselectedIcon: false,
        navigationRailIndicatorSchemeColor: SchemeColor.primary,
        navigationRailIndicatorOpacity: 1.00,
        navigationRailIndicatorRadius: 12.0,
        navigationRailBackgroundSchemeColor: SchemeColor.surface,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      fontFamily: GoogleFonts.varelaRound().fontFamily,
    );
  }
}








  // ThemeData get themeData {
  //   return ThemeData(
  //     useMaterial3: true,
  //     colorScheme: _colorScheme,
  //     textTheme: _textTheme,
  //     inputDecorationTheme: _inputDecorationTheme,
  //     filledButtonTheme: _filledButtonTheme,
  //     textButtonTheme: _textButtonTheme,
  //     outlinedButtonTheme: _outlinedButtonTheme,
  //     appBarTheme: _appBarTheme,
  //   );
  // }

  // static ColorScheme get _colorScheme {
  //   return const ColorScheme(
  //     brightness: Brightness.dark,
  //     primary: Color(0xFF2da6bf),
  //     onPrimary: Color(0xFFFDFDFD),
  //     primaryContainer: Color(0xFFc4d3fa),
  //     onPrimaryContainer: Color(0xFF112047),
  //     secondary: Color(0xFFF47114),
  //     onSecondary: Color(0xFFFDFDFD),
  //     secondaryContainer: Color(0xFFfcd4b9),
  //     onSecondaryContainer: Color(0xFF492206),
  //     error: Color(0xFFD85D5D),
  //     onError: Color(0xFFFDFDFD),
  //     surfaceContainerHighest: Color(0xFFFDFDFD),
  //     surface: Color(0xFF030100),
  //     onSurface: Color(0xFFFDFDFD),
  //   );
  // }

  // static TextTheme get _textTheme {
  //   const textTheme = TextTheme();

  //   final bodyFont = GoogleFonts.ubuntuTextTheme(textTheme);
  //   final headingFont = GoogleFonts.varelaRoundTextTheme(textTheme);

  //   return bodyFont.copyWith(
  //     displayLarge: headingFont.displayLarge,
  //     displayMedium: headingFont.displayMedium,
  //     displaySmall: headingFont.displaySmall,
  //     headlineLarge: headingFont.headlineLarge,
  //     headlineMedium: headingFont.headlineMedium,
  //     headlineSmall: headingFont.headlineSmall,
  //     bodyLarge: bodyFont.bodyLarge,
  //     bodyMedium: bodyFont.bodyMedium,
  //     bodySmall: bodyFont.bodySmall,
  //   );
  // }

  // static AppBarTheme get _appBarTheme {
  //   return AppBarTheme(
  //     elevation: 0.0,
  //     centerTitle: true,
  //     titleTextStyle: _textTheme.headlineSmall!.copyWith(
  //       fontSize: 22.0,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }

  // static InputDecorationTheme get _inputDecorationTheme {
  //   return InputDecorationTheme(
  //     labelStyle: _textTheme.bodyLarge!.copyWith(
  //       color: _colorScheme.onSurface,
  //     ),
  //     contentPadding: const EdgeInsets.all(16.0),
  //     filled: true,
  //     fillColor: Colors.grey.withOpacity(0.2),
  //     enabledBorder: _enabledBorder,
  //     focusedBorder: _focusedBorder,
  //     disabledBorder: _disabledBorder,
  //   );
  // }

  // static FilledButtonThemeData get _filledButtonTheme {
  //   return FilledButtonThemeData(
  //     style: FilledButton.styleFrom(
  //       minimumSize: const Size(76.0, 38.0),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //   );
  // }

  // static OutlinedButtonThemeData get _outlinedButtonTheme {
  //   return OutlinedButtonThemeData(
  //     style: OutlinedButton.styleFrom(
  //       foregroundColor: _colorScheme.surfaceContainerHighest,
  //       minimumSize: const Size(76.0, 38.0),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //   );
  // }

  // static TextButtonThemeData get _textButtonTheme {
  //   return TextButtonThemeData(
  //     style: TextButton.styleFrom(
  //       minimumSize: const Size(76.0, 38.0),
  //       foregroundColor: _colorScheme.primary,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //   );
  // }

  // static InputBorder get _enabledBorder => OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //       borderSide: const BorderSide(color: Colors.transparent),
  //     );

  // static InputBorder get _focusedBorder => OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //       borderSide: BorderSide(color: _colorScheme.primary),
  //     );

  // static InputBorder get _disabledBorder => OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //       borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
  //     );
