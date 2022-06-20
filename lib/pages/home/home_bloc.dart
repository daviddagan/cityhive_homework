import 'package:cityhive_homework/data/model/message/message.dart';
import 'package:cityhive_homework/data/source/messages/messages_repository.dart';
import 'package:cityhive_homework/pages/home/home_states_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';

/// Using cubit as my state managnment
class HomeCubit extends Cubit<BaseHomeState> {
  final MessagesRepository _messagesRepository;
  HomeCubit(this._messagesRepository) : super(InitialState());

  /// Clear list , Emit empty list
  clearList() {
    emit(MessagesListResult([]));
  }

  /// Get messages ///
  /// first emit [LoadingState] for update our ui
  /// then load our messages from server/local
  /// then emit [Message] list in case they null with [MessagesListResult] state
  /// we are using messages??[] , for preventing from null issues
  getMessages() async {
    emit(LoadingState());
    try {
      // load messages from cache after receiving it from server
      final List<Message>? messages = await _messagesRepository.loadMessagesDb();
      // final List<Message>? messages = [Message(id: "id", date: DateTime.now(), phoneNumber: "2334", messageBody: "boddyy")];
      emit(MessagesListResult(messages ?? []));
    } on DioError catch (dioError) {
      final code = dioError.response?.statusCode;
      final error = dioError.error;
      final stackTrace = dioError.stackTrace;
      final message = "Failed load messages,status code: $code, error: $error";
      emit(ErrorState(message, stackTrace));
    } catch (e, stackTrace) {
      final message = "failed load messages: $e";
      emit(ErrorState(message, stackTrace));
    }
  }

  updateMessagesLength(int len){
    emit(CreateMessages(len));
  }

  createMessages({String? phone, String? body}) async {
    emit(LoadingState());
    try {
      Message message = Message(phoneNumber: phone, messageBody: body);
      await _messagesRepository.createMessage(message);
      emit(CreateMessages(0));
    } on DioError catch (dioError) {
      final code = dioError.response?.statusCode;
      final error = dioError.error;
      final stackTrace = dioError.stackTrace;
      final message = "Failed load messages,status code: $code, error: $error";
      emit(ErrorState(message, stackTrace));
    } catch (e, stackTrace) {
      final message = "failed load messages: $e";
      emit(ErrorState(message, stackTrace));
    }
  }
}
