class CountryMapper {
  static const Map<String, String> _codes = {
    // Sudamérica
    'Argentina': 'ar', 'Brazil': 'br', 'Ecuador': 'ec', 'Colombia': 'co',
    'Uruguay': 'uy', 'Peru': 'pe', 'Chile': 'cl', 'Venezuela': 've',
    'Paraguay': 'py', 'Bolivia': 'bo',

    // Europa
    'Spain': 'es', 'France': 'fr', 'Germany': 'de', 'Italy': 'it',
    'Portugal': 'pt', 'Netherlands': 'nl', 'Belgium': 'be', 'Croatia': 'hr',
    'Switzerland': 'ch', 'Czechia': 'cz', 'Czech Republic': 'cz',
    'Serbia': 'rs', 'Denmark': 'dk', 'Sweden': 'se', 'Norway': 'no',
    'Poland': 'pl', 'Austria': 'at', 'Ukraine': 'ua', 'Russia': 'ru',
    'Turkey': 'tr', 'Türkiye': 'tr', 'Greece': 'gr', 'Romania': 'ro',
    'Hungary': 'hu', 'Slovakia': 'sk', 'Slovenia': 'si', 'Bulgaria': 'bg',
    'Finland': 'fi', 'Ireland': 'ie', 'Iceland': 'is', 'Wales': 'gb-wls',
    'Scotland': 'gb-sct', 'England': 'gb-eng', 'Northern Ireland': 'gb-nir',
    'Montenegro': 'me', 'Bosnia and Herzegovina': 'ba', 'Bosnia-Herzegovina': 'ba', 'Albania': 'al',
    'North Macedonia': 'mk', 'Macedonia': 'mk', 'Lithuania': 'lt',
    'Latvia': 'lv', 'Estonia': 'ee', 'Luxembourg': 'lu', 'Malta': 'mt',
    'Cyprus': 'cy', 'Georgia': 'ge', 'Armenia': 'am', 'Azerbaijan': 'az',
    'Belarus': 'by', 'Moldova': 'md', 'Kosovo': 'xk', 'Faroe Islands': 'fo',
    'Gibraltar': 'gi', 'Andorra': 'ad', 'Liechtenstein': 'li', 'Monaco': 'mc',
    'San Marino': 'sm', 'Vatican City': 'va',

    // Norteamérica, Centroamérica y Caribe
    'United States': 'us', 'USA': 'us', 'Mexico': 'mx', 'Canada': 'ca',
    'Costa Rica': 'cr', 'Panama': 'pa', 'Honduras': 'hn', 'El Salvador': 'sv',
    'Guatemala': 'gt', 'Nicaragua': 'ni', 'Belize': 'bz', 'Jamaica': 'jm',
    'Cuba': 'cu', 'Haiti': 'ht', 'Dominican Republic': 'do', 'Trinidad and Tobago': 'tt',
    'Bahamas': 'bs', 'Barbados': 'bb', 'Saint Lucia': 'lc', 'Grenada': 'gd',
    'Saint Vincent and the Grenadines': 'vc', 'Antigua and Barbuda': 'ag',
    'Dominica': 'dm', 'Saint Kitts and Nevis': 'kn', 'Puerto Rico': 'pr',
    'Bermuda': 'bm', 'Cayman Islands': 'ky', 'Aruba': 'aw',

    // África
    'Senegal': 'sn', 'Morocco': 'ma', 'Cameroon': 'cm', 'Ghana': 'gh',
    'Tunisia': 'tn', 'Nigeria': 'ng', 'Algeria': 'dz', 'Egypt': 'eg',
    'South Africa': 'za', 'Ivory Coast': 'ci', "Côte d'Ivoire": 'ci',
    'Mali': 'ml', 'Burkina Faso': 'bf', 'DR Congo': 'cd', 'Congo': 'cg',
    'Zambia': 'zm', 'Angola': 'ao', 'Mozambique': 'mz', 'Zimbabwe': 'zw',
    'Kenya': 'ke', 'Ethiopia': 'et', 'Tanzania': 'tz', 'Uganda': 'ug',
    'Sudan': 'sd', 'South Sudan': 'ss', 'Sierra Leone': 'sl', 'Liberia': 'lr',
    'Guinea': 'gn', 'Guinea-Bissau': 'gw', 'Gambia': 'gm', 'Benin': 'bj',
    'Togo': 'tg', 'Niger': 'ne', 'Chad': 'td', 'Central African Republic': 'cf',
    'Gabon': 'ga', 'Equatorial Guinea': 'gq', 'Rwanda': 'rw', 'Burundi': 'bi',
    'Somalia': 'so', 'Djibouti': 'dj', 'Mauritius': 'mu', 'Comoros': 'km',
    'Cape Verde': 'cv', 'Sao Tome and Principe': 'st', 'Seychelles': 'sc',
    'Lesotho': 'ls', 'Botswana': 'bw', 'Namibia': 'na', 'Eswatini': 'sz',
    'Swaziland': 'sz', 'Malawi': 'mw', 'Madagascar': 'mg', 'Libya': 'ly',
    'Mauritania': 'mr',

    // Asia
    'Japan': 'jp', 'South Korea': 'kr', 'Korea Republic': 'kr',
    'Korea DPR': 'kp', 'North Korea': 'kp', 'Australia': 'au',
    'Saudi Arabia': 'sa', 'IR Iran': 'ir', 'Iran': 'ir',
    'Iraq': 'iq', 'Jordan': 'jo', 'Qatar': 'qa', 'United Arab Emirates': 'ae',
    'UAE': 'ae', 'China': 'cn', 'India': 'in', 'Indonesia': 'id',
    'Thailand': 'th', 'Vietnam': 'vn', 'Philippines': 'ph', 'Malaysia': 'my',
    'Singapore': 'sg', 'Myanmar': 'mm', 'Cambodia': 'kh', 'Laos': 'la',
    'Mongolia': 'mn', 'Nepal': 'np', 'Bhutan': 'bt', 'Bangladesh': 'bd',
    'Sri Lanka': 'lk', 'Pakistan': 'pk', 'Afghanistan': 'af', 'Uzbekistan': 'uz',
    'Turkmenistan': 'tm', 'Tajikistan': 'tj', 'Kyrgyzstan': 'kg',
    'Kazakhstan': 'kz', 'Syria': 'sy', 'Lebanon': 'lb', 'Palestine': 'ps',
    'Israel': 'il', 'Yemen': 'ye', 'Oman': 'om', 'Kuwait': 'kw',
    'Bahrain': 'bh', 'Maldives': 'mv', 'Brunei': 'bn', 'East Timor': 'tl',
    'Timor-Leste': 'tl', 'Macau': 'mo', 'Hong Kong': 'hk', 'Chinese Taipei': 'tw',
    'Taiwan': 'tw',

    // Oceanía
    'New Zealand': 'nz', 'Fiji': 'fj', 'Papua New Guinea': 'pg',
    'Solomon Islands': 'sb', 'Vanuatu': 'vu', 'Samoa': 'ws',
    'Tonga': 'to', 'Kiribati': 'ki', 'Micronesia': 'fm',
    'Marshall Islands': 'mh', 'Palau': 'pw', 'Nauru': 'nr', 'Tuvalu': 'tv',
    'Cook Islands': 'ck', 'New Caledonia': 'nc', 'French Polynesia': 'pf',
    'Tahiti': 'pf', 'American Samoa': 'as', 'Guam': 'gu',
    'Northern Mariana Islands': 'mp',

  };

  /// Busca el código ISO 3166-1 alpha-2 (en minúscula) para el nombre de un país.
  ///
  /// La búsqueda ignora mayúsculas/minúsculas y espacios al inicio/final.
  /// Si no encuentra el país, retorna 'un' (Naciones Unidas) como bandera genérica.
  static String getCode(String countryName) {
    final trimmed = countryName.trim();
    final entry = _codes.entries.firstWhere(
      (e) => e.key.toLowerCase() == trimmed.toLowerCase(),
      orElse: () => const MapEntry('', 'un'),
    );
    return entry.value;
  }
}
