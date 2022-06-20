import 'package:cityhive_homework/pages/home/home_bloc.dart';
import 'package:cityhive_homework/widgets/error.dart';
import 'package:cityhive_homework/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cityhive_homework/utils/size_config.dart';
import 'package:flutter/material.dart';
import '../home_states_events.dart';

class CreateMeassage extends StatefulWidget {
  const CreateMeassage({Key? key, required this.state}) : super(key: key);
  final BaseHomeState state;

  @override
  _CreateMeassageState createState() => _CreateMeassageState();
}

class _CreateMeassageState extends State<CreateMeassage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: "+972509005070");
  final bodyController = TextEditingController();

  void clearForm() {
    bodyController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state.runtimeType) {
      case LoadingState:
        return circularProgress();
      case ErrorState:
        final message = (widget.state as ErrorState).message;
        return errorState(message);
      default: //will be InitialState
        return _createMessagesView(context);
    }
  }

  Widget _createMessagesView(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical),
              _title("Phone Number"),
              TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    border: OutlineInputBorder(),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter some text';
                    return null;
                  }),
              SizedBox(height: SizeConfig.spacing_large_vertical),
              _title("Message"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical),
                child: TextFormField(
                    controller: bodyController,
                    onChanged: (value) => context.read<HomeCubit>().updateMessagesLength(value.length),
                    maxLines: null,
                    minLines: 6,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.message),
                      border: OutlineInputBorder(),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter some text';

                      return null;
                    }),
              ),
              _messageLength(),
              SizedBox(height: SizeConfig.screenHeight / 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ElevatedButton(
                    child: const Text("Clear"),
                    onPressed: () {
                      clearForm();
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Colors.black45),
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                OutlinedButton(
                  child: const Text("Sumbit", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      context.read<HomeCubit>().createMessages(phone: phoneController.text, body: bodyController.text);
                      clearForm();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('please fill fields'),
                      ));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                ),
              ])
            ],
          )),
    );
  }

  Widget _messageLength() {
    return BlocBuilder<HomeCubit, BaseHomeState>(
      buildWhen: (previous, current) => current is CreateMessages,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${state is CreateMessages ? state.messageLength : 0}/250",
            style: const TextStyle(color: Colors.black45),
          ),
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: SizeConfig.font_medium_plus, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
