import 'package:dio/dio.dart';

class OptionBuilder{
  Options options = Options(headers: {});

  OptionBuilder jsonContent(){
    options.contentType = Headers.jsonContentType;
    return this;
  }

  OptionBuilder headers(String key, String value){
    options.headers![key] = value;
    return this;
  }

  OptionBuilder authorizeToken(String token){
    options.headers!["Authorization"] = "Bearer " + token;
    return this;
  }
  
  Options build() => options;
}