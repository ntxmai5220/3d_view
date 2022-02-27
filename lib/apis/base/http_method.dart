class HTTPMethod {
  final String value;
  const HTTPMethod._(this.value);
}

class HTTPMethods {
  static const HTTPMethod get = HTTPMethod._('GET');
  static const HTTPMethod post = HTTPMethod._('POST');
  static const HTTPMethod put = HTTPMethod._('PUT');
  static const HTTPMethod delete = HTTPMethod._('DELETE');
}
