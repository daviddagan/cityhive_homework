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
    setState(() {
      selectedIndex = index;
    });
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
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth / 4, vertical: SizeConfig.screenHeight / 8),
        child: BlocProvider<HomeCubit>(create: (context) => getIt.get<HomeCubit>(), child: _messagesBlocHandler()),
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
        fixedColor: Colors.black,
        onTap: onItemTapped,
        selectedLabelStyle: const TextStyle(color: Colors.red, fontSize: 15),
      ),
    );
  }

  Widget _messagesBlocHandler() {
    return BlocBuilder<HomeCubit, BaseHomeState>(
      builder: (context, state) => selectedIndex == 0 ? CreateMeassage(state: state) : MessagesListView(state: state),
    );
  }
}
