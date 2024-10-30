import 'package:dio/dio.dart';
import 'client.dart';

class EndPoints{

  EndPoints._();

  static EndPoints instanse(){
    return EndPoints._();
  }

  Future<Response> AdminEvent({required FormData data}) async {
    try{
      Response response = await dioClient.dio().post('Admin/Event.php', data: data);
      return response;
    }on DioException catch (e){
      return e.response!;
    }
  }
}