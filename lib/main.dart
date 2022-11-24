import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_app/firstPage.dart';
import 'package:project_app/screens/login_screen.dart';
import 'firebase_options.dart';
import 'homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrimeRepo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple[900],
        fontFamily: 'Ubuntu',
      ),
      home: Firstpage(),
    );
  }
}
