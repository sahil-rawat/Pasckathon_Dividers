import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/fine_list.dart';
import '../dashboard/dashboard.dart';

class FinePage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  FinePage({this.Sign_Out, this.Uid, this.name});
  // ignore: non_constant_identifier_names
  final Function Sign_Out;
  final String Uid;
  final String name;
  static const String id = "Fine Page";
  @override
  _FinePageState createState() => _FinePageState();
}

class _FinePageState extends State<FinePage> {
  Firestore _firestore = Firestore.instance;
  int namelength = 0;

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  Sign_out_google: widget.Sign_Out,
                  Uid: widget.Uid,
                  name: widget.name,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.brown.shade300,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Center(
              child: Text(
                "Total: " + namelength.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
          title: Text('Fine Collected'),
        ),
        body: Container(
          child: FineList(
            Uid: widget.Uid,
          ),
        ),
      ),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    _firestore
        .collection('fine')
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((element) {
        _firestore
            .collection('fine')
            .document(widget.Uid)
            .collection(widget.Uid)
            .getDocuments()
            .then((QuerySnapshot querySnapshot) {
          setState(() {
            namelength = (querySnapshot.documents.length == null)
                ? 0
                : querySnapshot.documents.length;
          });
        });
      });
    });
  }
}
