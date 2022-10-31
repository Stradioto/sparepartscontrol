import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sparepartscontrol/Login_Page.dart';
import 'package:sparepartscontrol/QR_Code_Page.dart';
import 'Login_Page.dart' as LP;


class VerifyLogin extends StatelessWidget {
  const VerifyLogin({ Key? key}) : super(key : key);

@override
Widget build(BuildContext context) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: Directionality(textDirection: TextDirection.ltr,
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const QRCODE(title: 'title',);
            }
             else {
              return const LoginPage();
            }
          }),
      ),
    ),
  );
}

}