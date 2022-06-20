import 'package:cityhive_homework/main.dart';
import 'package:cityhive_homework/pages/home/widgets/create_message.dart';
import 'package:cityhive_homework/pages/home/widgets/users_list_view.dart';
import 'package:cityhive_homework/utils/size_config.dart';
import 'package:cityhive_homework/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_bloc.dart';
import 'home_states_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //index of the chosen page
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    // switch (index) {
    //   case 0:
    //     break;
    //   case 1:
    //     context.read<HomeCubit>().getMessages();
    //     break;
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Sms Messenger"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.spacing_small_horizontal, vertical: SizeConfig.spacing_small_vertical),
        child: BlocProvider<HomeCubit>(
          create: (context) => getIt.get<HomeCubit>(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _clearButton(),
                  _button(),
                ],
              ),
              // SizedBox(
              //   height: SizeConfig.spacing_medium_vertical,
              // ),
              Expanded(child: _messagesBlocHandler()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.blue,
              ),
              label: "New message"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Colors.blue,
              ),
              label: "Message History"),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: onItemTapped,
        selectedLabelStyle: const TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }

  Widget _button() {
    return BlocBuilder<HomeCubit, BaseHomeState>(builder: (context, state) {
      final enable = state is! LoadingState;
      return CustomButton(
        enable: enable,
        text: "load messages",
        color: enable ? Colors.blue : Colors.grey.withOpacity(0.5),
        onClick: () => context.read<HomeCubit>().getMessages(),
      );
    });
  }

  Widget _clearButton() {
    return BlocBuilder<HomeCubit, BaseHomeState>(
      builder: (context, state) {
        final opacity = state is MessagesListResult && (state).messages.isNotEmpty ? 1.0 : 0.0;
        return AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: CustomButton(
            enable: opacity == 1,
            text: "clear",
            onClick: () => context.read<HomeCubit>().clearList(),
          ),
        );
      },
    );
  }

  Widget _messagesBlocHandler() {
    return BlocBuilder<HomeCubit, BaseHomeState>(
      builder: (context, state) => selectedIndex == 0 ? CreateMeassage(state: state) : MessagesListView(state: state),
    );
  }
}
