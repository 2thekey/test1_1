import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}
class _AddScreenState extends State<AddScreen> {
  String title;
  String price;
  String purchase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("ADD BOOK")
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText:"title"),
            onChanged: (value){title = value;},
          ),
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText:"price(only number)"),
            keyboardType: TextInputType.number,
            onChanged: (value){price = value;},
          ),
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText:"purchased?(true / false)"),
            onChanged: (value){purchase = value;},
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              bool check = (purchase == 'true');
              print(price);
              print(title);
              print(check);
              Firestore.instance.collection("books").document(title)                  .setData({"price":int.parse(price),"title":title,
                "purchase?":check});
              Navigator.pop(context);
            },
            child: Text("Finish"),
          ),
        ],
      ),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);