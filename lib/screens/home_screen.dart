import 'dart:math';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/game_theme.dart';
import '../models/player.dart';
import '../services/player_service.dart';
import 'game_screen.dart';
import 'leaderboard_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final GameTheme theme;
  final ValueChanged<GameTheme> onThemeChanged;
  final List<Player> players;
  final List<String> activePlayerIds;
  final VoidCallback onPlayersChanged;

  const HomeScreen({
    super.key,
    required this.theme,
    required this.onThemeChanged,
    required this.players,
    required this.activePlayerIds,
    required this.onPlayersChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mega TTT',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: theme.title,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 48),
                _MenuItem(
                  icon: Icons.play_arrow_rounded,
                  label: l10n.newGame,
                  theme: theme,
                  onTap: () => _startNewGame(context, l10n),
                ),
                const SizedBox(height: 16),
                _MenuItem(
                  icon: Icons.emoji_events_rounded,
                  label: l10n.leaderboard,
                  theme: theme,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MenuItem(
                  icon: Icons.settings_rounded,
                  label: l10n.settings,
                  theme: theme,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SettingsScreen(
                          theme: theme,
                          onThemeChanged: onThemeChanged,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startNewGame(BuildContext context, AppLocalizations l10n) async {
    final state = MyApp.of(context);
    if (state == null) return;

    final active = state.activePlayers;
    if (active.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.needTwoActivePlayers),
          backgroundColor: theme.accent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final shuffled = List<Player>.from(active)..shuffle(Random());
    final playerX = shuffled[0];
    final playerO = shuffled[1];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(
          theme: theme,
          playerXId: playerX.id,
          playerXName: playerX.name,
          playerOId: playerO.id,
          playerOName: playerO.name,
          onGameEnd: (result) async {
            if (result == 'draw') {
              await PlayerService.recordDraw(playerX.id);
              await PlayerService.recordDraw(playerO.id);
            } else {
              final winnerId = result == 'X' ? playerX.id : playerO.id;
              final loserId = result == 'X' ? playerO.id : playerX.id;
              await PlayerService.recordWin(winnerId);
              await PlayerService.recordLoss(loserId);
            }
            onPlayersChanged();
          },
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final GameTheme theme;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: theme.accent.withOpacity(0.3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: theme.accent, size: 28),
                ),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.text,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded, color: theme.text.withOpacity(0.4), size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
