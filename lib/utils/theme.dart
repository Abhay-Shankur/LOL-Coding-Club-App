import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kThemeModeKey = '__theme_mode__';

abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
    // return DarkModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  abstract Color primary;
  abstract Color secondary;
  abstract Color tertiary;
  abstract Color alternate;
  abstract Color primaryText;
  abstract Color secondaryText;
  abstract Color primaryBackground;
  abstract Color secondaryBackground;
  abstract Color accent1;
  abstract Color accent2;
  abstract Color accent3;
  abstract Color accent4;
  abstract Color success;
  abstract Color warning;
  abstract Color error;
  abstract Color info;

  abstract Color primaryBtnText;
  abstract Color lineColor;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme{
  @override
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @override
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @override
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  @override
  Color primary = const Color(0xFFFFBE00);
  @override
  Color secondary = const Color(0xFFFFC952);
  @override
  Color tertiary = const Color(0xFFFFA130);
  @override
  Color alternate = const Color(0xFFE0E3E7);
  @override
  Color primaryText = const Color(0xFF14181B);
  @override
  Color secondaryText = const Color(0xFF57636C);
  @override
  Color primaryBackground = const Color(0xFFF1F4F8);
  @override
  Color secondaryBackground = const Color(0xFFFFFFFF);
  @override
  Color accent1 = const Color(0x4C19DB8A);
  @override
  Color accent2 = const Color(0x4D36B4FF);
  @override
  Color accent3 = const Color(0x4DFFA130);
  @override
  Color accent4 = const Color(0xabffffff);
  @override
  Color success = const Color(0xFF16B070);
  @override
  Color warning = const Color(0xFFCC8E30);
  @override
  Color error = const Color(0xFFFF5963);
  @override
  Color info = const Color(0xFFFFFFFF);

  @override
  Color primaryBtnText = const Color(0xFFFFFFFF);
  @override
  Color lineColor = const Color(0xFFE0E3E7);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  @override
  String get displayLargeFamily => 'PT Sans';
  @override
  TextStyle get displayLarge => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 64.0,
      );
  @override
  String get displayMediumFamily => 'PT Sans';
  @override
  TextStyle get displayMedium => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44.0,
      );
  @override
  String get displaySmallFamily => 'PT Sans';
  @override
  TextStyle get displaySmall => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  @override
  String get headlineLargeFamily => 'PT Sans';
  @override
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  @override
  String get headlineMediumFamily => 'PT Sans';
  @override
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  @override
  String get headlineSmallFamily => 'PT Sans';
  @override
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      );
  @override
  String get titleLargeFamily => 'PT Sans';
  @override
  TextStyle get titleLarge => GoogleFonts.getFont(
        'PT Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  @override
  String get titleMediumFamily => 'Roboto Mono';
  @override
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.info,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
      );
  @override
  String get titleSmallFamily => 'Roboto Mono';
  @override
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.info,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  @override
  String get labelLargeFamily => 'Roboto Mono';
  @override
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  @override
  String get labelMediumFamily => 'Roboto Mono';
  @override
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  @override
  String get labelSmallFamily => 'Roboto Mono';
  @override
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  @override
  String get bodyLargeFamily => 'Roboto Mono';
  @override
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  @override
  String get bodyMediumFamily => 'Roboto Mono';
  @override
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  @override
  String get bodySmallFamily => 'Roboto Mono';
  @override
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Roboto Mono',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends AppTheme {
  @override
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @override
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @override
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  @override
  Color primary = const Color(0xFFFFBE00);
  @override
  Color secondary = const Color(0xFFFFC952);
  @override
  Color tertiary = const Color(0xFFFFA130);
  @override
  Color alternate = const Color(0xFF2B323B);
  @override
  Color primaryText = const Color(0xFFFFFFFF);
  @override
  Color secondaryText = const Color(0xFF95A1AC);
  @override
  Color primaryBackground = const Color(0xFF14181B);
  @override
  Color secondaryBackground = const Color(0xFF1D2429);
  @override
  Color accent1 = const Color(0x4C19DB8A);
  @override
  Color accent2 = const Color(0x4D36B4FF);
  @override
  Color accent3 = const Color(0x4DFFA130);
  @override
  Color accent4 = const Color(0xB214181B);
  @override
  Color success = const Color(0xFF16B070);
  @override
  Color warning = const Color(0xFFCC8E30);
  @override
  Color error = const Color(0xFFFF5963);
  @override
  Color info = const Color(0xFFFFFFFF);

  @override
  Color primaryBtnText = const Color(0xFFFFFFFF);
  @override
  Color lineColor = const Color(0xFF22282F);
}

extension TextStyleHelper on TextStyle {
  TextStyle overriden({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}

