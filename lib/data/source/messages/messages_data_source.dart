import 'package:cityhive_homework/data/model/message/message.dart';

abstract class MessagesDataSourceLocal {
  Future<void> saveMessagesDb(List<Message> messages);

  Future<List<Message>?> loadMessagesDb();
}

abstract class MessagesDataSourceRemote {
  Future<List<Message>> getMessages();
  Future createMessage(Message message);
}
