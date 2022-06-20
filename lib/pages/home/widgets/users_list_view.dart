import 'package:cityhive_homework/data/model/message/message.dart';
import 'package:cityhive_homework/pages/home/home_bloc.dart';
import 'package:cityhive_homework/utils/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../home_states_events.dart';

class MessagesListView extends StatelessWidget {
  final BaseHomeState state;

  const MessagesListView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case LoadingState:
        return _circularProgress();
      case MessagesListResult:
        final messages = (state as MessagesListResult).messages;
        return _messagesListView(messages);
      case ErrorState:
        final message = (state as ErrorState).message;
        return _errorState(message);
      default: //will be InitialState
        return _firstTime(context);
    }
  }

  Widget _firstTime(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.read<HomeCubit>().getMessages(),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(114, 137, 218, 1),
          elevation: 30,
          shape: const CircleBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(maxWidth: 180, maxHeight: 180), // min sizes for Material buttons
            alignment: Alignment.center,
            child: const Text(
              'Show Messages History',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorState(String? message) {
    return Text(
      message ?? "Failed load messages",
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _circularProgress() {
    return Center(
      child: SizedBox(height: SizeConfig.screenHeight / 5, width: SizeConfig.screenHeight / 5, child: const CircularProgressIndicator()),
    );
  }

  Widget _messagesListView(List<Message> messages) {
    return ListView.separated(
      itemCount: messages.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemBuilder: (context, index) => _messageItem(messages[index]),
    );
  }

  Widget _messageItem(Message message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message.phoneNumber ?? "",
              style: TextStyle(fontSize: SizeConfig.font_medium, fontWeight: FontWeight.bold),
            ),
            Text(message.date!.toIso8601String())
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
          child: Container(
            height: SizeConfig.screenHeight / 5,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black45, width: 0.5),
            ),
            child: Text(message.messageBody ?? ""),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${(message.messageBody ?? "").length.toString()}/250",
            style: const TextStyle(color: Colors.black45),
          ),
        )
      ],
    );
  }
}
