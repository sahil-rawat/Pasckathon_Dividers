import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dashboard/dashboard.dart';
import '../components/scan_list.dart';

class ScanPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  ScanPage({this.Sign_out, this.Uid, this.name});
  // ignore: non_constant_identifier_names
  final Function Sign_out;
  final String Uid;
  final String name;
  static const String id = "Scan Page";
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  int namelength = 0;
  Firestore _firestore = Firestore.instance;

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  Sign_out_google: widget.Sign_out,
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
          title: Text('Scan results'),
        ),
        body: Container(
          child: ScanList(
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
        .collection('scan')
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((element) {
        _firestore
            .collection('scan')
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
