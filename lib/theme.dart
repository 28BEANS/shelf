import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const listItem = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const section = 32.0;
}

const shelfScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFCCFF00),
  onPrimary: Color(0xFF1A1A1A),
  primaryContainer: Color(0xFFE8FF8C),
  onPrimaryContainer: Color(0xFF1A1A1A),
  secondary: Color(0xFFC7CEEA),
  onSecondary: Color(0xFF1A1A1A),
  secondaryContainer: Color(0xFFE8EBF8),
  onSecondaryContainer: Color(0xFF1A1A1A),
  tertiary: Color(0xFFB5EAD7),
  onTertiary: Color(0xFF1A1A1A),
  tertiaryContainer: Color(0xFFDDF7EE),
  onTertiaryContainer: Color(0xFF1A1A1A),
  error: Color(0xFFBA1A1A),
  onError: Colors.white,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  surface: Colors.white,
  onSurface: Color(0xFF1A1A1A),
  surfaceContainerHighest: Color(0xFFF1ECEB),
  onSurfaceVariant: Color(0xFF45413F),
  outline: Color(0xFF1A1A1A),
  outlineVariant: Color(0xFFCBC5C3),
  shadow: Color(0xFF1A1A1A),
  scrim: Color(0xFF1A1A1A),
  inverseSurface: Color(0xFF30302F),
  onInverseSurface: Color(0xFFF8F0EE),
  inversePrimary: Color(0xFFB1D900),
  surfaceTint: Colors.transparent,
);

final shelfTheme = ThemeData(
  useMaterial3: true,
  colorScheme: shelfScheme,
  scaffoldBackgroundColor: const Color(0xFFF5F0EF),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 34,
      height: 40 / 34,
      fontWeight: FontWeight.w800,
      color: shelfScheme.onSurface,
    ),
    headlineSmall: GoogleFonts.plusJakartaSans(
      fontSize: 23,
      height: 29 / 23,
      fontWeight: FontWeight.w800,
      color: shelfScheme.onSurface,
    ),
    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: shelfScheme.onSurface,
    ),
    titleMedium: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: shelfScheme.onSurface,
    ),
    bodyMedium: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      height: 20 / 14,
      color: shelfScheme.onSurface,
    ),
    labelSmall: GoogleFonts.spaceMono(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF373737),
    ),
    labelLarge: GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: shelfScheme.onSurface,
    ),
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    margin: EdgeInsets.zero,
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF1A1A1A), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF1A1A1A), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF1A1A1A), width: 3),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: shelfScheme.primary,
      foregroundColor: shelfScheme.onPrimary,
      minimumSize: const Size.fromHeight(48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: const BorderSide(color: Color(0xFF1A1A1A), width: 1.5),
      ),
      textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFF5F0EF),
    foregroundColor: shelfScheme.onSurface,
    elevation: 0,
  ),
);
