import 'dart:io';
import 'package:sparepartscontrol/Piece_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

logOut() async{
    FirebaseAuth.instance.signOut();
  }



String QRData = "";

class QRCODE extends StatefulWidget {
  const QRCODE({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QRCODE> createState() => _QRCODEState();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _QRCODEState extends State<QRCODE> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  final qrTextFieldController = TextEditingController();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode:ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,debugShowCheckedModeBanner: false,
      home: Builder( builder: (context) => 
        Scaffold(
        body: Column(
          children: <Widget>[ const SizedBox(height: 25),const Align(alignment: Alignment.topRight ,child: ElevatedButton(onPressed: logOut,      
          child: Text("LogOut"),
          ),
          ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                                  overlay: QrScannerOverlayShape(
                      borderWidth: 10,
                      borderColor: const Color.fromARGB(255, 235, 107, 84),
                      borderLength: 70,
                      borderRadius: 20,
                      //cutOutSize: MediaQuery.of(context).size.width * 0.8,
                    ),
      
              ),
            ),
            ElevatedButton(onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PieceScreen(QRData: QRData)),
          );
      }, child: Text('${result?.code}')),
                                Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          IconButton(
                              icon: const Icon(
                                Icons.flip_camera_ios,
                                color: Color.fromARGB(255, 235, 107, 84),
                              ),
                              onPressed: () async {
                                await controller?.flipCamera();
                              }),
                          IconButton(
                              icon: const Icon(
                                Icons.flash_on,
                                color: Color.fromARGB(255, 235, 107, 84),
                              ),
                              onPressed: () async {
                                await controller?.toggleFlash();
                              }),
                          ],
                      ),
          ],
        ),
          ),
      ),);
  }

  

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        
      });
      QRData = scanData.code as String;
      
      {
      
    }
    });
    
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ThemeClass{
 
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
                        elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Color.fromARGB(255, 255, 255, 255),
                        primary: Color.fromARGB(255, 235, 107, 84),
                      ),
                    )

  );
 
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
                        elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Color.fromARGB(255, 0, 0, 0),
                        primary: Color.fromARGB(255, 235, 107, 84),
                      ),
                    )

  );
}