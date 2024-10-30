import 'package:dio/dio.dart';

class Client{
  // Client._();
  String _baseUrl='https://tlda.org.in/api/';
  Dio dio(){
    return Dio(BaseOptions(baseUrl: _baseUrl));
  }
}

Client dioClient = Client();