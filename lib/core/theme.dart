import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF6D00); // برتقالي
  static const secondary = Color(0xFFFFAB40); // برتقالي فاتح
  static const muted = Color(0xFF8A94A8);
  static const danger = Color(0xFFFF5C7A);
  static const success = Color(0xFF2DD4A0);
}

const kGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.primary, AppColors.secondary],
);

const kHeroGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Color(0xFFE65100), Color(0xFFFF6D00), Color(0xFFFFAB40)],
);

class AppPalette {
  final Color bg, card, border, text, muted;
  const AppPalette(
      {required this.bg,
      required this.card,
      required this.border,
      required this.text,
      required this.muted});

  static const dark = AppPalette(
      bg: Color(0xFF0D0D0D),
      card: Color(0xFF1A1A1A),
      border: Color(0x1FFFFFFF),
      text: Colors.white,
      muted: Color(0xFF8A94A8));

  static const light = AppPalette(
      bg: Color(0xFFF5F5F5),
      card: Colors.white,
      border: Color(0x14000000),
      text: Color(0xFF1A1A1A),
      muted: Color(0xFF6B7385));
}

extension PaletteX on BuildContext {
  AppPalette get pal => Theme.of(this).brightness == Brightness.dark
      ? AppPalette.dark
      : AppPalette.light;
}

ThemeData buildTheme(Brightness b) {
  final p = b == Brightness.dark ? AppPalette.dark : AppPalette.light;
  final base = ThemeData(brightness: b);
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: b,
  ).copyWith(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: p.card,
    onSurface: p.text,
  );
  return ThemeData(
    useMaterial3: true,
    brightness: b,
    colorScheme: scheme,
    scaffoldBackgroundColor: p.bg,
    textTheme: base.textTheme.apply(bodyColor: p.text, displayColor: p.text),
    appBarTheme: AppBarTheme(
      backgroundColor: p.bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: p.text,
      titleTextStyle:
          TextStyle(color: p.text, fontSize: 18, fontWeight: FontWeight.w800),
    ),
    cardTheme: CardThemeData(
      color: p.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: p.border)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.card,
      labelStyle: TextStyle(color: p.muted),
      hintStyle: TextStyle(color: p.muted),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: p.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: p.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: p.card,
      selectedColor: AppColors.primary.withValues(alpha: 0.25),
      side: BorderSide(color: p.border),
      labelStyle: TextStyle(color: p.text, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      showCheckmark: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.primary.withValues(alpha: 0.2),
      labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: p.text)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: p.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      thumbColor: AppColors.secondary,
      inactiveTrackColor: p.border,
      overlayColor: AppColors.primary.withValues(alpha: 0.15),
    ),
    dividerColor: p.border,
  );
}
