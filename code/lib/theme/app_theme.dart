import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color bg = Color(0xFF0C0C0D);
  static const Color surface = Color(0xFF181819);
  static const Color surface2 = Color(0xFF222224);
  static const Color surface3 = Color(0xFF2A2A2C);
  static const Color cardBg = Color(0xFF1E1E20);
  static const Color accent = Color(0xFFC8200A);
  static const Color yellow = Color(0xFFF5C400);
  static const Color text1 = Color(0xFFFFFFFF);
  static const Color text2 = Color(0x70FFFFFF); // 44%
  static const Color text3 = Color(0x3DFFFFFF); // 24%
  static const Color border = Color(0x0FFFFFFF); //  6%
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle wordmark = GoogleFonts.dmSans(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
    color: AppColors.yellow,
    letterSpacing: 0.5,
    shadows: const [Shadow(offset: Offset(2, 2), color: AppColors.accent)],
  );

  static TextStyle sectionTitle = GoogleFonts.dmSans(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.text1,
    letterSpacing: -0.3,
  );

  static TextStyle sectionCount = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.text3,
  );

  static TextStyle cardName = GoogleFonts.dmSans(
    fontSize: 13.5,
    fontWeight: FontWeight.w700,
    color: AppColors.text1,
    letterSpacing: -0.1,
    height: 1.25,
  );

  static TextStyle cardDesc = GoogleFonts.dmSans(
    fontSize: 11.5,
    fontWeight: FontWeight.w400,
    color: AppColors.text2,
    height: 1.4,
  );

  static TextStyle cardPrice = GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.yellow,
  );

  static TextStyle catPill = GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle statusPill = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static TextStyle orderToggle = GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static TextStyle navLabel = GoogleFonts.dmSans(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
}

class AppTheme {
  AppTheme._();

  static SystemUiOverlayStyle get systemOverlay => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.surface,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
  );
}
