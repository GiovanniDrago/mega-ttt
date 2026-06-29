enum DistributionChannel {
  direct,
  play,
}

class AppDistributionConfig {
  const AppDistributionConfig({
    required this.channel,
    required this.aboutUrl,
    this.donationUrl,
  });

  factory AppDistributionConfig.fromEnvironment() {
    const channelName = String.fromEnvironment(
      'DISTRIBUTION_CHANNEL',
      defaultValue: 'direct',
    );

    return AppDistributionConfig(
      channel: channelName == 'play'
          ? DistributionChannel.play
          : DistributionChannel.direct,
      aboutUrl: const String.fromEnvironment(
        'ABOUT_URL',
        defaultValue: 'https://github.com/GiovanniDrago/mega-ttt',
      ),
      donationUrl: _normalizedDonationUrl(
        const String.fromEnvironment(
          'DONATION_URL',
          defaultValue: 'https://buymeacoffee.com/_takasu_',
        ),
      ),
    );
  }

  final DistributionChannel channel;
  final String aboutUrl;
  final String? donationUrl;

  bool get isDirect => channel == DistributionChannel.direct;

  bool get supportsDonation =>
      isDirect && donationUrl != null && donationUrl!.isNotEmpty;

  static String? _normalizedDonationUrl(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
