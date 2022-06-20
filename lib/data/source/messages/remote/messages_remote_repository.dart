import 'package:cityhive_homework/data/model/message/message.dart';
import 'package:cityhive_homework/data/source/messages/api/messages_api.dart';
import 'package:cityhive_homework/data/source/messages/messages_data_source.dart';

class MessagesRemoteRepository implements MessagesDataSourceRemote {
  final MessagesApi _api;

  MessagesRemoteRepository(this._api);

  @override
  Future<List<Message>> getMessages() async {
    return _api.getMessages().then((response) => response);
  }
  @override
  Future createMessage(Message message) async {
    return _api.createMessage(message).then((response) => response);
  }
}
