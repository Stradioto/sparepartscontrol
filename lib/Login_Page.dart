import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sparepartscontrol/QR_Code_Page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyLoginPage();
}
//
String userEmail = "";

//verify
class _MyLoginPage extends State<LoginPage> {


final emailTextFieldController = TextEditingController();
final passwordTextFieldController = TextEditingController();

Future logIn() async {
  await FirebaseAuth.instance.signInWithEmailAndPassword
  (email: emailTextFieldController.text.trim(), password: passwordTextFieldController.text.trim());
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
           child: SingleChildScrollView(
             child: Column (
                     mainAxisAlignment: MainAxisAlignment.center,children: [
                   Image.asset('assets/VoiLogo.png', width: 250,),
                   const SizedBox(height: 50),
                   const Text("Welcome, you must login to proceed."),
                   SizedBox(width:  400,child: Column ( children: [
                   const SizedBox(height: 30),
                   TextField(controller: emailTextFieldController, decoration: InputDecoration(filled: true,labelStyle: const TextStyle(color: Color.fromARGB(255, 235, 107, 84)),labelText: 'E-Mail',hintText: "@voiapp.io",floatingLabelBehavior: FloatingLabelBehavior.always,enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Color.fromARGB(255, 235, 107, 84), width: 1.0),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Color.fromARGB(255, 235, 107, 84), width: 1.0),),),),
                   const SizedBox(height: 10),
                   TextField(controller: passwordTextFieldController, decoration: InputDecoration(filled: true,labelStyle: const TextStyle(color: Color.fromARGB(255, 235, 107, 84)),labelText: 'Password',floatingLabelBehavior: FloatingLabelBehavior.always,enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Color.fromARGB(255, 235, 107, 84), width: 1.0),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Color.fromARGB(255, 235, 107, 84), width: 1.0),),),
                   obscureText: true,
                   enableSuggestions: false,
                   autocorrect: false,
                   )
                   ],),),
                   const SizedBox(height: 40),
                   SizedBox(height: 50.0, width: 400, child:
                   ElevatedButton(onPressed: logIn, child: const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 235, 107, 84),shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),),),),
                   ),
                   const SizedBox(height: 10),
                   SizedBox(height: 50.0, width: 400, child:
                   ElevatedButton(onPressed: () async{
                      await signInWithGoogle();
                      
                      setState(() {
                        
                      });
                   }, child: const Text("CONTINUE WITH GMAIL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 156, 156, 156),shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),),),),
                   ),
                   ],),
           ),),),), 
      debugShowCheckedModeBanner: false,
      themeMode:ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
    );
  }

}

class ThemeClass{
 
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),

  );
 
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),

  );
}
//verify
Future<UserCredential> signInWithGoogle() async {
  
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    userEmail = googleUser.email;

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  //verify
