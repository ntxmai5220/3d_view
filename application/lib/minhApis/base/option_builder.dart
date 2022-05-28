import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:dio/dio.dart';

class OptionBuilder {
  Options options = Options(headers: {});

  OptionBuilder jsonContent() {
    options.contentType = Headers.jsonContentType;
    return this;
  }

  OptionBuilder headers(String key, String value) {
    options.headers![key] = value;
    return this;
  }

  OptionBuilder authorizeToken() {
    options.headers!["Authorization"] =
        "Bearer ${HelperSharedPreferences.savedToken}";

    return this;
  }

  Options build() => options;
}
