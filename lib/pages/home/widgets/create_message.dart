import 'package:cityhive_homework/pages/home/home_bloc.dart';
import 'package:cityhive_homework/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_states_events.dart';

class CreateMeassage extends StatefulWidget {
  const CreateMeassage({Key? key, required this.state}) : super(key: key);
  final BaseHomeState state;

  @override
  _CreateMeassageState createState() => _CreateMeassageState();
}

class _CreateMeassageState extends State<CreateMeassage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formValues = {};

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number",
                style: TextStyle(fontSize: SizeConfig.font_medium_plus, color: Colors.black),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),
            Container(
              height: SizeConfig.spacing_extra_vertical,
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black45, width: 0.5),
              ),
              child: TextFormField(
                  keyboardType: TextInputType.phone,
                  initialValue: "+972509005070",
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      formValues["phone"] = value;
                    }
                    return null;
                  }),
            ),
            SizedBox(height: SizeConfig.spacing_large_vertical),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Message",
                style: TextStyle(fontSize: SizeConfig.font_medium_plus, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeVertical),
              child: Container(
                height: SizeConfig.screenHeight / 3,
                width: SizeConfig.screenWidth,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black45, width: 0.5),
                ),
                child: TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    formValues["body"] = value;
                  }
                  return null;
                }),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "0/250",
                style: TextStyle(color: Colors.black45),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                  child: const Text("Clear"),
                  onPressed: null,
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
                    context.read<HomeCubit>().createMessages(formValues);
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
        ));
  }
}
