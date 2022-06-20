import 'package:cityhive_homework/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'application/getitmodules/bloc_binding_module.dart';
import 'application/getitmodules/net_binding_module.dart';
import 'application/getitmodules/repository_binding_module.dart';

/// This is our global ServiceLocator/Dependency injection
GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerGetItModules();
  runApp(FutureBuilder(
    future: getIt.allReady(),
    builder: (context, snapshot) {
      final doneInitAll = snapshot.connectionState == ConnectionState.done && snapshot.hasData;
      return doneInitAll ? const MyApp() : const Loader();
    }
  ));
}

registerGetItModules(){
  NetBindingModule.provideNetModules();
  RepositoryBindingModule.provideModules();
  BlocBindingModule.provideModules();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My sms messenger',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}



