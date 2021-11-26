import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

var dd="";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var fsconnect = FirebaseFirestore.instance;


  myget() async {
    await fsconnect.collection('books')
        .doc('lotto')
        .get()
        .then((DocumentSnapshot ds) {
      // ignore: unnecessary_statements
      dd=ds.data()['bunho'];
      //print(dd);
    }
    );


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

                  print(dd);
                },
              )

            ],
          ),

        ));
  }
}