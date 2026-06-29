import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_distribution.dart';
import '../../l10n/app_localizations.dart';

class AboutDialogContent extends StatelessWidget {
  const AboutDialogContent({
    super.key,
    required this.distribution,
  });

  final AppDistributionConfig distribution;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.aboutDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aboutDialogGreeting,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Text(
            distribution.supportsDonation
                ? l10n.aboutDirectMessage
                : l10n.aboutPlayMessage,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: distribution.supportsDonation
                ? FilledButton.tonalIcon(
                    onPressed: () => _openExternalLink(
                      context,
                      distribution.donationUrl!,
                    ),
                    icon: const Icon(Icons.coffee_rounded, size: 18),
                    label: Text(l10n.aboutDonationButton),
                  )
                : FilledButton.tonalIcon(
                    onPressed: () => _openExternalLink(
                      context,
                      distribution.aboutUrl,
                    ),
                    icon: const Icon(Icons.code_rounded, size: 18),
                    label: Text(l10n.aboutGithubButton),
                  ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.closeButton),
        ),
      ],
    );
  }

  Future<void> _openExternalLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final l10n = AppLocalizations.of(context)!;

    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.externalLinkError)),
    );
  }
}
