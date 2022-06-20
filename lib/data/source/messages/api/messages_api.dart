import 'package:cityhive_homework/application/api_configuration.dart';
import 'package:cityhive_homework/data/model/message/message.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'messages_api.g.dart';

@RestApi(baseUrl: ApiConfiguration.BASE_URL)
abstract class MessagesApi {
  factory MessagesApi(Dio dio, {String baseUrl}) = _MessagesApi;

  @GET("messages/")
  Future<List<Message>> getMessages();
  @POST("messages/")
  Future createMessage(Message message);
}
