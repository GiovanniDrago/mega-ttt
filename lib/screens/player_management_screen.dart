import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/game_theme.dart';
import '../models/player.dart';

class PlayerManagementScreen extends StatefulWidget {
  const PlayerManagementScreen({super.key});

  @override
  State<PlayerManagementScreen> createState() => _PlayerManagementScreenState();
}

class _PlayerManagementScreenState extends State<PlayerManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = MyApp.of(context);
    if (state == null) return const SizedBox.shrink();

    final theme = state.theme;
    final players = state.players;
    final activeIds = List<String>.from(state.activePlayerIds);

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
          l10n.managePlayers,
          style: TextStyle(color: theme.text, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int i = 0; i < players.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                color: theme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: activeIds.contains(players[i].id)
                      ? BorderSide(color: theme.accent, width: 2)
                      : BorderSide(color: theme.text.withOpacity(0.08)),
                ),
                elevation: activeIds.contains(players[i].id) ? 3 : 0,
                shadowColor: theme.accent.withOpacity(0.25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: theme.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.person_rounded, color: theme.accent, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          players[i].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.text,
                          ),
                        ),
                      ),
                      _SmallIconButton(
                        icon: Icons.edit_rounded,
                        color: theme.text.withOpacity(0.5),
                        theme: theme,
                        onTap: () => _editName(players[i]),
                      ),
                      const SizedBox(width: 4),
                      _SmallIconButton(
                        icon: Icons.delete_outline_rounded,
                        color: Colors.red.withOpacity(0.6),
                        theme: theme,
                        onTap: () => _confirmDelete(players[i]),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: activeIds.contains(players[i].id),
                        activeTrackColor: theme.accent,
                        onChanged: (_) => _toggleActive(players[i].id, activeIds),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _resetLeaderboard,
              icon: const Icon(Icons.delete_sweep_rounded, size: 20),
              label: Text(l10n.resetLeaderboard),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red.withOpacity(0.7),
                side: BorderSide(color: Colors.red.withOpacity(0.3)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addPlayer,
              icon: const Icon(Icons.add_rounded, size: 20),
              label: Text(l10n.addPlayer),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.buttonBg,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _toggleActive(String playerId, List<String> activeIds) {
    final state = MyApp.of(context);
    if (state == null) return;

    if (activeIds.contains(playerId)) {
      activeIds.remove(playerId);
    } else {
      if (activeIds.length >= 2) {
        activeIds.removeAt(0);
      }
      activeIds.add(playerId);
    }
    state.setActivePlayerIds(activeIds);
  }

  void _resetLeaderboard() {
    final state = MyApp.of(context);
    if (state == null) return;
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: state.theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.resetLeaderboard, style: TextStyle(color: state.theme.text)),
        content: Text(
          l10n.resetLeaderboardConfirm,
          style: TextStyle(color: state.theme.text.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel, style: TextStyle(color: state.theme.text.withOpacity(0.6))),
          ),
          TextButton(
            onPressed: () {
              state.resetAllScores();
              Navigator.pop(ctx);
            },
            child: Text(l10n.reset, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _addPlayer() {
    final state = MyApp.of(context);
    if (state == null) return;
    final l10n = AppLocalizations.of(context)!;

    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: state.theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.newPlayer, style: TextStyle(color: state.theme.text)),
        content: TextField(
          controller: controller,
          autofocus: false,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            final name = controller.text.trim();
            if (name.isNotEmpty) {
              state.addPlayer(name);
              Navigator.pop(ctx);
            }
          },
          style: TextStyle(color: state.theme.text),
          decoration: InputDecoration(
            hintText: l10n.enterName,
            hintStyle: TextStyle(color: state.theme.text.withOpacity(0.4)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: state.theme.text.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: state.theme.accent),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel, style: TextStyle(color: state.theme.text.withOpacity(0.6))),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                state.addPlayer(name);
                Navigator.pop(ctx);
              }
            },
            child: Text(l10n.create, style: TextStyle(color: state.theme.accent)),
          ),
        ],
      ),
    );
  }

  void _editName(Player player) {
    final state = MyApp.of(context);
    if (state == null) return;
    final l10n = AppLocalizations.of(context)!;

    final controller = TextEditingController(text: player.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: state.theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.editName, style: TextStyle(color: state.theme.text)),
        content: TextField(
          controller: controller,
          autofocus: false,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            final name = controller.text.trim();
            if (name.isNotEmpty) {
              state.updatePlayer(player.id, name);
              Navigator.pop(ctx);
            }
          },
          style: TextStyle(color: state.theme.text),
          decoration: InputDecoration(
            hintText: l10n.enterName,
            hintStyle: TextStyle(color: state.theme.text.withOpacity(0.4)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: state.theme.text.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: state.theme.accent),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel, style: TextStyle(color: state.theme.text.withOpacity(0.6))),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                state.updatePlayer(player.id, name);
                Navigator.pop(ctx);
              }
            },
            child: Text(l10n.save, style: TextStyle(color: state.theme.accent)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Player player) {
    final state = MyApp.of(context);
    if (state == null) return;
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: state.theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.deletePlayer, style: TextStyle(color: state.theme.text)),
        content: Text(
          l10n.deletePlayerConfirm(player.name),
          style: TextStyle(color: state.theme.text.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel, style: TextStyle(color: state.theme.text.withOpacity(0.6))),
          ),
          TextButton(
            onPressed: () {
              state.deletePlayer(player.id);
              Navigator.pop(ctx);
            },
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SmallIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final GameTheme theme;
  final VoidCallback onTap;

  const _SmallIconButton({
    required this.icon,
    required this.color,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }
}
