import 'package:cityhive_homework/data/model/message/message.dart';

///
/// HOME STATES
///
/// states that we will receive from home bloc
///
abstract class BaseHomeState {}

class InitialState extends BaseHomeState {}

class LoadingState extends BaseHomeState {}

class MessagesListResult extends BaseHomeState {
  final List<Message> messages;
  MessagesListResult(this.messages);
}

class CreateMessages extends BaseHomeState {
  final int messageLength;
  CreateMessages(this.messageLength);
}

class ErrorState extends BaseHomeState {
  final String? message;
  final StackTrace? stackTrace;

  ErrorState(this.message, this.stackTrace);
}
