class CountryMapper {
  static const Map<String, String> _codes = {
    'Argentina': 'ar', 'Brazil': 'br', 'Ecuador': 'ec', 'Colombia': 'co',
    'Uruguay': 'uy', 'Peru': 'pe', 'Chile': 'cl', 'Venezuela': 've',
    'Paraguay': 'py', 'Bolivia': 'bo', 'Spain': 'es', 'France': 'fr',
    'Germany': 'de', 'England': 'gb-eng', 'Italy': 'it', 'Portugal': 'pt',
    'Netherlands': 'nl', 'Belgium': 'be', 'Croatia': 'hr', 'Switzerland': 'ch',
    'United States': 'us', 'USA': 'us', 'Mexico': 'mx', 'Canada': 'ca', 'Costa Rica': 'cr',
    'Japan': 'jp', 'South Korea': 'kr', 'Korea Republic': 'kr', 'Australia': 'au', 'Saudi Arabia': 'sa',
    'IR Iran': 'ir', 'Iran': 'ir', 'Senegal': 'sn', 'Morocco': 'ma', 'Cameroon': 'cm', 'Ghana': 'gh',
    'Czechia': 'cz', 'Czech Republic': 'cz', 'Serbia': 'rs', 'Denmark': 'dk', 'Tunisia': 'tn',
  };

  static String getCode(String countryName) {
    return _codes[countryName] ?? 'xx';
  }
}
