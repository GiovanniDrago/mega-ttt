import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class GameTheme {
  final String themeKey;
  final Color background;
  final Color surface;
  final Color title;
  final Color text;
  final Color xColor;
  final Color oColor;
  final Color gridColor;
  final Color winLineColor;
  final Color accent;
  final Color buttonBg;
  final Brightness brightness;
  final Color seedColor;

  const GameTheme({
    required this.themeKey,
    required this.background,
    required this.surface,
    required this.title,
    required this.text,
    required this.xColor,
    required this.oColor,
    required this.gridColor,
    required this.winLineColor,
    required this.accent,
    required this.buttonBg,
    required this.brightness,
    required this.seedColor,
  });

  Color get statusDefaultBg => text.withOpacity(0.05);

  String localizedName(AppLocalizations l10n) {
    switch (themeKey) {
      case 'themeDarkNavy':
        return l10n.themeDarkNavy;
      case 'themeMidnightPurple':
        return l10n.themeMidnightPurple;
      case 'themeForest':
        return l10n.themeForest;
      case 'themeOcean':
        return l10n.themeOcean;
      case 'themeSunset':
        return l10n.themeSunset;
      case 'themeLightClassic':
        return l10n.themeLightClassic;
      default:
        return themeKey;
    }
  }

  Color get statusDefaultBorder => text.withOpacity(0.1);
  Color get statusXBorder => xColor;
  Color get statusOBorder => oColor;
  Color get statusXBackground => xColor.withOpacity(0.2);
  Color get statusOBackground => oColor.withOpacity(0.2);

  ThemeData toThemeData() {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ),
      useMaterial3: true,
    );
    return base.copyWith(
      scaffoldBackgroundColor: background,
      popupMenuTheme: PopupMenuThemeData(color: surface),
    );
  }

  static const themes = <GameTheme>[
    GameTheme(
      themeKey: 'themeDarkNavy',
      background: Color(0xFF1A1A2E),
      surface: Color(0xFF2A2A4E),
      title: Color(0xE6FFFFFF),
      text: Color(0xCCFFFFFF),
      xColor: Color(0xFF4FC3F7),
      oColor: Color(0xFFEF5350),
      gridColor: Color(0x4DFFFFFF),
      winLineColor: Color(0xFF69F0AE),
      accent: Color(0xFF64B5F6),
      buttonBg: Colors.deepPurple,
      brightness: Brightness.dark,
      seedColor: Color(0xFF1A237E),
    ),
    GameTheme(
      themeKey: 'themeMidnightPurple',
      background: Color(0xFF1A0A2E),
      surface: Color(0xFF2E1A4E),
      title: Color(0xE6FFFFFF),
      text: Color(0xCCFFFFFF),
      xColor: Color(0xFF80CBC4),
      oColor: Color(0xFFCE93D8),
      gridColor: Color(0x4DBA68C8),
      winLineColor: Color(0xFFA5D6A7),
      accent: Color(0xFFCE93D8),
      buttonBg: Color(0xFF7B1FA2),
      brightness: Brightness.dark,
      seedColor: Color(0xFF4A148C),
    ),
    GameTheme(
      themeKey: 'themeForest',
      background: Color(0xFF0D1B0E),
      surface: Color(0xFF1A3A1A),
      title: Color(0xE6FFFFFF),
      text: Color(0xCCFFFFFF),
      xColor: Color(0xFFAED581),
      oColor: Color(0xFFFF8A65),
      gridColor: Color(0x4D66BB6A),
      winLineColor: Color(0xFFFFD54F),
      accent: Color(0xFF81C784),
      buttonBg: Color(0xFF2E7D32),
      brightness: Brightness.dark,
      seedColor: Color(0xFF1B5E20),
    ),
    GameTheme(
      themeKey: 'themeOcean',
      background: Color(0xFF0D1B2A),
      surface: Color(0xFF1A2E4E),
      title: Color(0xE6FFFFFF),
      text: Color(0xCCFFFFFF),
      xColor: Color(0xFF4DD0E1),
      oColor: Color(0xFFFFAB91),
      gridColor: Color(0x4D4FC3F7),
      winLineColor: Color(0xFF80DEEA),
      accent: Color(0xFF4FC3F7),
      buttonBg: Color(0xFF0277BD),
      brightness: Brightness.dark,
      seedColor: Color(0xFF01579B),
    ),
    GameTheme(
      themeKey: 'themeSunset',
      background: Color(0xFF2E1A0A),
      surface: Color(0xFF4E2A1A),
      title: Color(0xE6FFFFFF),
      text: Color(0xCCFFFFFF),
      xColor: Color(0xFFFFD54F),
      oColor: Color(0xFFFF7043),
      gridColor: Color(0x4DFF8A65),
      winLineColor: Color(0xFF80D8FF),
      accent: Color(0xFFFF8A65),
      buttonBg: Color(0xFFE65100),
      brightness: Brightness.dark,
      seedColor: Color(0xFFBF360C),
    ),
    GameTheme(
      themeKey: 'themeLightClassic',
      background: Color(0xFFF5F5F5),
      surface: Colors.white,
      title: Color(0xDE000000),
      text: Color(0x8A000000),
      xColor: Color(0xFF1565C0),
      oColor: Color(0xFFC62828),
      gridColor: Color(0xFFBDBDBD),
      winLineColor: Color(0xFF2E7D32),
      accent: Colors.blue,
      buttonBg: Colors.blue,
      brightness: Brightness.light,
      seedColor: Color(0xFF1565C0),
    ),
  ];
}
