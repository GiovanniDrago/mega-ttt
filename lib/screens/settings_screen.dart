import 'package:flutter/material.dart';
import '../app_distribution.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/game_theme.dart';
import '../services/update_service.dart';
import 'interactions/about_dialog.dart';
import 'player_management_screen.dart';
import 'theme_selection_screen.dart';

class SettingsScreen extends StatefulWidget {
  final GameTheme theme;
  final ValueChanged<GameTheme> onThemeChanged;

  const SettingsScreen({super.key, required this.theme, required this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final version = await UpdateService.currentVersion;
    if (mounted) setState(() => _version = version);
  }

  String _currentLanguageName(AppLocalizations l10n) {
    final locale = MyApp.of(context)?.locale;
    if (locale?.languageCode == 'it') return l10n.languageItalian;
    return l10n.languageEnglish;
  }

  void _showLanguagePicker(BuildContext context) {
    final state = MyApp.of(context);
    if (state == null) return;
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: state.theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.language, style: TextStyle(color: state.theme.text)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.languageEnglish, style: TextStyle(color: state.theme.text)),
              leading: Icon(
                state.locale.languageCode == 'en' ? Icons.radio_button_checked : Icons.radio_button_off,
                color: state.theme.accent,
              ),
              onTap: () {
                state.setLocale(const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(l10n.languageItalian, style: TextStyle(color: state.theme.text)),
              leading: Icon(
                state.locale.languageCode == 'it' ? Icons.radio_button_checked : Icons.radio_button_off,
                color: state.theme.accent,
              ),
              onTap: () {
                state.setLocale(const Locale('it'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.closeButton, style: TextStyle(color: state.theme.text.withOpacity(0.6))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = MyApp.of(context)?.theme ?? widget.theme;

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
          l10n.settings,
          style: TextStyle(color: theme.text, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              l10n.appearance,
              style: TextStyle(
                color: theme.text.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Card(
            color: theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: theme.accent.withOpacity(0.2),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ThemeSelectionScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.palette_rounded, color: theme.accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      l10n.themes,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, color: theme.text.withOpacity(0.4), size: 22),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              l10n.players,
              style: TextStyle(
                color: theme.text.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Card(
            color: theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: theme.accent.withOpacity(0.2),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlayerManagementScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.people_rounded, color: theme.accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      l10n.managePlayers,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, color: theme.text.withOpacity(0.4), size: 22),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              l10n.language,
              style: TextStyle(
                color: theme.text.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Card(
            color: theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: theme.accent.withOpacity(0.2),
            child: InkWell(
              onTap: () => _showLanguagePicker(context),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.language_rounded, color: theme.accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      l10n.language,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _currentLanguageName(l10n),
                      style: TextStyle(
                        color: theme.text.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right_rounded, color: theme.text.withOpacity(0.4), size: 22),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: theme.accent.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.info_outline_rounded, color: theme.accent, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.version,
                        style: TextStyle(
                          color: theme.text.withOpacity(0.6),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _version.isNotEmpty ? l10n.versionFormat(_version) : l10n.loading,
                        style: TextStyle(
                          color: theme.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => UpdateService.check(context, silent: false),
              icon: const Icon(Icons.system_update_rounded, size: 20),
              label: Text(l10n.checkForUpdates),
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
          const SizedBox(height: 24),
          Card(
            color: theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: theme.accent.withOpacity(0.2),
            child: InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AboutDialogContent(
                    distribution: AppDistributionConfig.fromEnvironment(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.info_outline_rounded, color: theme.accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      l10n.aboutMenuItem,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded, color: theme.text.withOpacity(0.4), size: 22),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
