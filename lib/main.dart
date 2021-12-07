//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

var num=List.generate(1000,(i) => List(10), growable:false);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var fsconnect = FirebaseFirestore.instance;

  myget() async {
    int aa=0;
    String bb;
    await fsconnect.collection('naepo_lotto').orderBy("drwNo", descending: false).snapshots().listen((data) {
    data.docs.forEach((d) {

      bb=(d.id).toString();
      //print(aa);
      num[aa+1][0]=(data.docs[aa]['bnusNo']);
      num[aa+1][1]=(data.docs[aa]['drwtNo1']);
      num[aa+1][2]=(data.docs[aa]['drwtNo2']);
      num[aa+1][3]=(data.docs[aa]['drwtNo3']);
      num[aa+1][4]=(data.docs[aa]['drwtNo4']);
      num[aa+1][5]=(data.docs[aa]['drwtNo5']);
      num[aa+1][6]=(data.docs[aa]['drwtNo6']);
      num[aa+1][7]=(data.docs[aa]['bnusNo']);
      num[aa+1][8]=(data.docs[aa]['drwNoDate']);
     // print(data.docs[aa]['bnusNo']);
      aa++;

    });

    });


    // var soon='2';
    // await fsconnect.collection('naepo_lotto')
    //     .doc(soon)
    //     .get()
    //     .then((DocumentSnapshot ds) {
    //   // ignore: unnecessary_statements
    //   dd=ds.data()['bnusNo'].toString();
    //  // print(dd);
    // });

    // await fsconnect.collection('books')
    //     .doc('lotto')
    //     .get()
    //     .then((DocumentSnapshot ds) {
    //   // ignore: unnecessary_statements
    //   dd=ds.data()['bunho'];
    //   //print(dd);
    // }
    // );

        }



  @override
  Widget build(BuildContext context) {

    myget();

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Firebase Firestore App'),
          ),
          body: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('send data'),
                onPressed: () {
                  fsconnect.collection("books").add({
                    'name': 'sarah',
                    'title': 'xyz',
                    'email': 'sarah@gmail.com',
                  });
                  print("send ..");
                },
              ),
              RaisedButton(
                child: Text('get data'),
                onPressed: () {

                  print(num[1][1]);
                  print(num[100][1]);
                  print(num[101][1]);
                  print(num[102][1]);

                },
              )

            ],
          ),

        ));
  }
}