class AppAssets {
  AppAssets._();

  // Illustrative vector SVGs in string format to prevent missing file errors
  static const String logoSvg = '''<svg width="100" height="100" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M50 5L85 25V65L50 85L15 65V25L50 5Z" fill="url(#paint0_linear)" stroke="#F59E0B" stroke-width="2"/>
    <path d="M50 20L75 35V60L50 75L25 60V35L50 20Z" fill="#111827" fill-opacity="0.6"/>
    <circle cx="50" cy="48" r="10" fill="#F59E0B"/>
    <path d="M50 38V58M40 48H60" stroke="#F9FAFB" stroke-width="2" stroke-linecap="round"/>
    <defs>
      <linearGradient id="paint0_linear" x1="15" y1="5" x2="85" y2="85" gradientUnits="userSpaceOnUse">
        <stop stop-color="#6366F1"/>
        <stop offset="1" stop-color="#8B5CF6"/>
      </linearGradient>
    </defs>
  </svg>''';

  static const String onboarding1Svg = '''<svg width="200" height="200" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
    <circle cx="100" cy="100" r="80" fill="url(#gradient)" fill-opacity="0.15"/>
    <path d="M60 130C60 100 85 75 115 75H140" stroke="#6366F1" stroke-width="4" stroke-linecap="round"/>
    <rect x="70" y="80" width="60" height="90" rx="12" fill="#1F2937" stroke="#8B5CF6" stroke-width="3"/>
    <circle cx="100" cy="105" r="15" fill="#F59E0B"/>
    <line x1="85" y1="140" x2="115" y2="140" stroke="#9CA3AF" stroke-width="3" stroke-linecap="round"/>
    <defs>
      <linearGradient id="gradient" x1="20" y1="20" x2="180" y2="180" gradientUnits="userSpaceOnUse">
        <stop stop-color="#6366F1"/>
        <stop offset="1" stop-color="#8B5CF6"/>
      </linearGradient>
    </defs>
  </svg>''';

  static const String onboarding2Svg = '''<svg width="200" height="200" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
    <circle cx="100" cy="100" r="80" fill="url(#gradient)" fill-opacity="0.15"/>
    <path d="M100 50V150M50 100H150" stroke="#8B5CF6" stroke-width="3" stroke-linecap="round" stroke-dasharray="6 6"/>
    <circle cx="100" cy="100" r="30" fill="#1F2937" stroke="#F59E0B" stroke-width="4"/>
    <circle cx="100" cy="100" r="10" fill="#6366F1"/>
    <defs>
      <linearGradient id="gradient" x1="20" y1="20" x2="180" y2="180" gradientUnits="userSpaceOnUse">
        <stop stop-color="#8B5CF6"/>
        <stop offset="1" stop-color="#6366F1"/>
      </linearGradient>
    </defs>
  </svg>''';

  static const String onboarding3Svg = '''<svg width="200" height="200" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
    <circle cx="100" cy="100" r="80" fill="url(#gradient)" fill-opacity="0.15"/>
    <path d="M60 110L90 140L140 70" stroke="#10B981" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
    <defs>
      <linearGradient id="gradient" x1="20" y1="20" x2="180" y2="180" gradientUnits="userSpaceOnUse">
        <stop stop-color="#10B981"/>
        <stop offset="1" stop-color="#6366F1"/>
      </linearGradient>
    </defs>
  </svg>''';
}
