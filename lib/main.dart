import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
     var dd=ds.data()['bunho'];
     print(dd);
    }
    );

   //print(d);

    // var bbb=d.data().toString();
    // print(bbb);
    // var arr=bbb.split('/');
    //
    // print(arr[0]);
    // print(arr[8]);


    // print(d.docs[0].data());

    // for (var i in d.docs) {
    //   print(i.data());
    //}
  }

  @override
  Widget build(BuildContext context) {
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
                  myget();
                  print("get data ...");
                },
              )

            ],
          ),

        ));
  }
}