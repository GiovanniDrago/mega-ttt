import 'package:flutter/material.dart';
import '../main.dart';
import '../models/game_theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = MyApp.of(context);
    final theme = state?.theme ?? GameTheme.themes[0];
    final players = state?.players ?? [];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: theme.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Leaderboard',
          style: TextStyle(color: theme.text, fontWeight: FontWeight.w600),
        ),
      ),
      body: players.isEmpty
          ? Center(
              child: Text(
                'No players yet',
                style: TextStyle(color: theme.text.withOpacity(0.5), fontSize: 16),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final player in players)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      color: theme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      shadowColor: theme.accent.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: theme.accent.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.emoji_events_rounded,
                                      color: theme.accent, size: 26),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    player.name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: theme.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _StatChip(
                                  label: 'Wins',
                                  value: player.wins,
                                  color: const Color(0xFF4CAF50),
                                  theme: theme,
                                ),
                                const SizedBox(width: 12),
                                _StatChip(
                                  label: 'Losses',
                                  value: player.losses,
                                  color: const Color(0xFFEF5350),
                                  theme: theme,
                                ),
                                const SizedBox(width: 12),
                                _StatChip(
                                  label: 'Draws',
                                  value: player.draws,
                                  color: const Color(0xFFFFA726),
                                  theme: theme,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final GameTheme theme;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                fontSize: 13,
                color: theme.text.withOpacity(0.6),
              ),
            ),
            TextSpan(
              text: '$value',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
