import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sparepartscontrol/QR_Code_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'QR_Code_Page.dart' as QRPAGE;

import 'package:flutter/material.dart';



class PieceScreen extends StatefulWidget {
  
  // ignore: non_constant_identifier_names
  final String? QRData;

  // ignore: non_constant_identifier_names
  PieceScreen({Key? key, required this.QRData}) : super(key: key);

  @override
_PieceScreen createState() => _PieceScreen();
}

  class _PieceScreen extends State<PieceScreen> {
    final Stream<QuerySnapshot> pieces = FirebaseFirestore.instance.collection('pieces').snapshots();
    //String? aux = QRData.toString();
    List<String> items = ['IoT','Motor'];
    String selectedItem = 'IoT';

  @override
  Widget build(BuildContext context) {
    CollectionReference pieces = FirebaseFirestore.instance.collection('pieces');
    return MaterialApp(debugShowCheckedModeBanner: false,themeMode:ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 235, 107, 84),
          title: Text('Piece No. ${QRData}'),
        ),
        body: Center(
          child:
          
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('pieces').doc(QRData).get(),
          builder: (_, snapshot) {
          if (snapshot.hasError) { return const Text ('Error'); }
          if (snapshot.hasData) {
          var data = snapshot.data!.data();
          
          
          selectedItem = '${data!['Type']}';
          if (data == null) {
          return 
          Center(
          child: Column(textDirection: TextDirection.ltr,
          children: [
            const SizedBox(height: 80),
            Row(children: [const SizedBox(width: 65),const Text('Create entry with code ', style: TextStyle(fontSize: 15),),Text('$QRData?', style: TextStyle(fontSize: 30,background: Paint()..color = const Color.fromARGB(255, 235, 107, 84),),),],
            ),
            DropdownButton<String>(value: selectedItem,items: items.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
            onChanged: (item) => setState(() {
              selectedItem = item!;
            }),),
            const SizedBox(height: 40),
            Row(children: [const SizedBox(width: 100),
            ElevatedButton(onPressed: () {
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRCODE(title: '',)),
        );
            }, child: const Text('Return'),),const SizedBox(width: 20),
            ElevatedButton(onPressed: () {
              pieces.doc(QRData).set({"Type": selectedItem});
              setState(() {});//pieces.doc().set('test');
            }, child: const Text('Create'),)],),
            
            ],
          ),);
          }
          if (data['Type'] == "Motor") {
          return 
          Column(children: [
            const SizedBox(height: 100),
            Row(children: [DropdownButton<String>(value: selectedItem,items: items.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
            onChanged: (item) => setState(() {
              selectedItem = item!;
            }),),//(value: 'Type: ${data['Type']}', items: const [', onChanged: (String? value) {  },), ElevatedButton(onPressed: () {}, child: const Text('Modify'))]),
            const SizedBox(height: 25),
            Text('State: ${data['State']}'),
            const SizedBox(height: 25),
            Text('Tyre: ${data['Tyre']}'),
            const SizedBox(height: 25),
            Text('Working: ${data['Working']}'),
            const SizedBox(height: 25),
            Text('Note: ${data['Note']}')
            ]
            )
          ]);
          }
          if (data['Type'] == "IoT") {
          return 
          
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              const SizedBox(height: 100),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Type: '),
                  DropdownButton<String>(value: selectedItem,items: items.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
                  onChanged: (item) => setState(() {
                    selectedItem = item!;
                  }),),
                ],
              ),
              const SizedBox(height: 25),
              Row(children: [const SizedBox(width: 100) , Text('State: ${data['State']}'), const SizedBox(width: 10), ElevatedButton(onPressed: () {}, child: const Text('Modify'))]),
              const SizedBox(height: 25),
              Text('Case: ${data['Case']}'),
              const SizedBox(height: 25),
              Text('Lights: ${data['Lights']}'),
              const SizedBox(height: 25),
              Text('Antenna: ${data['Antenna']}'),
              const SizedBox(height: 25),
              Text('Flash(Tentative): ${data['Flash(Tentative)']}'),
              const SizedBox(height: 25),
              Text('Note: ${data['Note']}')
              ]),
          );
          
          }
          }

    return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 235, 107, 84))));
  },
),
          
          
      ),
    ),);
  }
}

