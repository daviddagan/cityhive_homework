import 'package:cityhive_homework/data/source/messages/local/users_local_repository.dart';
import 'package:cityhive_homework/data/source/messages/remote/messages_remote_repository.dart';
import 'package:cityhive_homework/data/source/messages/messages_data_source.dart';
import 'package:cityhive_homework/data/source/messages/messages_repository.dart';

import '../../main.dart';

class RepositoryBindingModule {
  static provideModules() {
    _provideMessagesRepository();
  }

  static _provideMessagesRepository() {
    getIt.registerSingleton<MessagesDataSourceRemote>(MessagesRemoteRepository(getIt.get()));
    getIt.registerSingleton<MessagesDataSourceLocal>(MessagesLocalRepository());
    getIt.registerSingleton(MessagesRepository(getIt.get(), getIt.get()));
  }
}
