import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/game_theme.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = MyApp.of(context);
    final theme = state?.theme ?? GameTheme.themes[0];

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
          l10n.themes,
          style: TextStyle(color: theme.text, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int i = 0; i < GameTheme.themes.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                color: theme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: theme == GameTheme.themes[i]
                      ? BorderSide(color: theme.accent, width: 2)
                      : BorderSide(color: theme.text.withOpacity(0.08)),
                ),
                elevation: theme == GameTheme.themes[i] ? 3 : 0,
                shadowColor: theme.accent.withOpacity(0.25),
                child: InkWell(
                  onTap: () => state?.setTheme(GameTheme.themes[i]),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: GameTheme.themes[i].background,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: GameTheme.themes[i].accent,
                              width: 2.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          GameTheme.themes[i].localizedName(l10n),
                          style: TextStyle(
                            color: theme.text,
                            fontSize: 16,
                            fontWeight: theme == GameTheme.themes[i]
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        if (theme == GameTheme.themes[i])
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: theme.accent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 16),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
