import 'package:cityhive_homework/data/model/message/message.dart';
import 'package:cityhive_homework/data/source/messages/messages_data_source.dart';

class MessagesRepository {
  final MessagesDataSourceLocal _local;
  final MessagesDataSourceRemote _remote;

  MessagesRepository(this._local, this._remote);

  ///
  /// Load messages
  ///
  /// first load messages from local repository (in our Floor db)
  /// then check if its not null or empty,
  /// in case false return current results
  /// in case true load it from api,save it in out local db then load it
  ///
  /// CACHING ENGINE WITH REPOSITORY PATTERN
  /// -----------------
  /// Local   Remote
  ///   Repository
  /// -----------------
  /// 
  Future<List<Message>?> loadMessagesDb() async {
    List<Message> m = await _remote.getMessages();
    return m;
    // return _local.loadMessagesDb().then((messagesDb) async {
    //   if (messagesDb == null || messagesDb.isEmpty) {
    //     print(await _remote.getMessages());
    //     return _remote.getMessages().then((messages) => _local.saveMessagesDb(messages)).then((_) => _local.loadMessagesDb());
    //   } else {
    //     return messagesDb;
    //   }
    // });
  }

  Future createMessage(Message message)async{
    await _remote.createMessage(message);
  }
}
