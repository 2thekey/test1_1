import 'dart:async';

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var num=List.generate(1000,(i) => List(10), growable:false);

void main() async {
  // int lotto_cha=1;
  // String url= "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$lotto_cha";
  // var response = await http.get(url);
  //
  // Map<String, dynamic> lotto = json.decode(response.body);
  //
  // num[lotto_cha][0] = lotto["drwNo"];
  // num[lotto_cha][1] = lotto["drwNoDate"];
  // num[lotto_cha][2] = lotto["drwtNo1"];
  // num[lotto_cha][3] = lotto["drwtNo2"];
  // num[lotto_cha][4] = lotto["drwtNo3"];
  // num[lotto_cha][5] = lotto["drwtNo4"];
  // num[lotto_cha][6] = lotto["drwtNo5"];
  // num[lotto_cha][7] = lotto["drwtNo6"];
  // num[lotto_cha][8] = lotto["bnusNo"];
  // num[lotto_cha][9] = lotto["returnValue"];
  // lotto_cha++;
  //
  //
  // while(num[lotto_cha-1][9]=="success") {
  //   url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$lotto_cha";
  //   response = await http.get(url);
  //   lotto = json.decode(response.body);
  //   num[lotto_cha][0] = lotto["drwNo"];
  //   num[lotto_cha][1] = lotto["drwNoDate"];
  //   num[lotto_cha][2] = lotto["drwtNo1"];
  //   num[lotto_cha][3] = lotto["drwtNo2"];
  //   num[lotto_cha][4] = lotto["drwtNo3"];
  //   num[lotto_cha][5] = lotto["drwtNo4"];
  //   num[lotto_cha][6] = lotto["drwtNo5"];
  //   num[lotto_cha][7] = lotto["drwtNo6"];
  //   num[lotto_cha][8] = lotto["bnusNo"];
  //   num[lotto_cha][9] = lotto["returnValue"];
  //
  //   lotto_cha++;
  // } //while
  //
  //
  // print('aa');
  //  print(num[980]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  //FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference fireStore = FirebaseFirestore.instance.collection('books');
    return FutureBuilder<DocumentSnapshot>(
        future: fireStore.doc('lotto').get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: Text("hello world"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    //color: Colors.blue,
                    child: Text("create button",style: TextStyle(color : Colors.white)),
                    onPressed: (){
                      //클릭시 데이터를 추가해준다.
                    },
                  ),
                  ElevatedButton(
                    //color: Colors.blue,
                    child: Text("read button", style: TextStyle(color : Colors.white)),
                    onPressed: (){

                      Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                      print(data['bunho'] );


                    },
                  ),
                  ElevatedButton(
                    //color: Colors.blue,
                    child: Text("update button", style: TextStyle(color : Colors.white)),
                    onPressed: (){
                      //클릭시 데이터를 갱신해준다.
                    },
                  ),
                  ElevatedButton(
                    //color: Colors.blue,
                    child: Text("delete button", style: TextStyle(color : Colors.white)),
                    onPressed: (){
                      //클릭시 데이터를 삭제해 준다.
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}