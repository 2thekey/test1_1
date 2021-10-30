import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());



class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return SomethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return MyApp();
  }
}

class SomethingWentWrong extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "SomethingWentWrong",
        home:Scaffold(
            appBar: AppBar(title:Text("SomethingWentWrong!!")),
            body:Text("SomethingWentWrong!!!!")

        )

    );
  }
}

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Loading",
        home:Scaffold(
            appBar: AppBar(title:Text("Loading!!")),
            body:Text("Loading!!!!")

        )

    );
  }
}


final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // // TODO: get actual snapshot from Cloud Firestore
    // return _buildList(context, dummySnapshot);

    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection("baby").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        }

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context,
      List<QueryDocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, QueryDocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () => record.reference.update({'vote':FieldValue.increment(1)})
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['vote'] != null),
        name = map['name'],
        votes = map['vote'];

  Record.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}