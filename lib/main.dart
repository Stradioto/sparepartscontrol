import 'package:sparepartscontrol/Verify_Login.dart';
import 'Verify_Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(const VerifyLogin());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerifyLogin(),
    );
  }
}




