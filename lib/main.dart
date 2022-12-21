import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app_constants.dart';
import 'package:flutter_firebase/on_generate_route.dart';

import 'dependency_injection.dart' as di;
import 'feature/presentation/page/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      //initialRoute: PageConst.defaultPage,
      //onGenerateRoute: OnGenerateRoute.route,
      home: const HomePage(),
    );
  }
}
