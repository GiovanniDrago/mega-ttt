import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_theme.dart';

class ThemeService {
  static const _key = 'selected_theme';

  static Future<GameTheme> load() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key) ?? 0;
    if (index >= 0 && index < GameTheme.themes.length) {
      return GameTheme.themes[index];
    }
    return GameTheme.themes[0];
  }

  static Future<void> save(GameTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    final index = GameTheme.themes.indexOf(theme);
    await prefs.setInt(_key, index);
  }
}
