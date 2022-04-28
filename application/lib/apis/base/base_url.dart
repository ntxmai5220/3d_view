class BaseURL {
  const BaseURL._({
    required this.schemes,
    required this.host,
    required this.basePath,
  });

  final String schemes;
  final String host;
  final String basePath;
  String get url => schemes + host + basePath;
}

class BaseURLs {
  static const BaseURL address = BaseURL._(
    schemes: 'https://',
    host: 'online-gateway.ghn.vn',
    basePath: '/shiip/public-api/master-data/',
  );
  static const BaseURL app = BaseURL._(
    schemes: 'https://',
    host: 'thesis-api.onrender.com',
    basePath: '/v1/3dview/',
  );
}
