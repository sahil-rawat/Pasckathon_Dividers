import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slimy_card/slimy_card.dart';

// ignore: must_be_immutable
class ScanList extends StatefulWidget {
  ScanList({this.Uid});
  final String Uid;
  @override
  _ScanListState createState() => _ScanListState();
}

class _ScanListState extends State<ScanList> {
  Firestore _firestore = Firestore.instance;
  int length;
  List<SlimyCard> scancard1 = [];
  @override
  // ignore: must_call_super
  void initState() {
    _firestore.collection('scan').getDocuments().then((QuerySnapshot querySnapshot){
      querySnapshot.documents.forEach((element) {
        _firestore.collection('scan').document(widget.Uid).collection(widget.Uid).getDocuments().then((QuerySnapshot querySnapshot){
          setState(() {
            length=querySnapshot.documents.length;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: slimyCard.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('scan').document(widget.Uid).collection(widget.Uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            final messages = snapshot.data.documents;
            for (var name in messages) {
              final nameText = name.data['name'];
              final adharno = name.data['adhar'];
              final namecard = SlimyCard(
                color: Colors.purple[100],
                width: 400,
                topCardHeight: 150,
                bottomCardHeight: 100,
                borderRadius: 15,
                topCardWidget: topCardWidget(name: nameText),
                bottomCardWidget: bottomCardWidget(adharNumber: adharno),
                slimeEnabled: true,
              );
              scancard1.add(namecard);
            }
            return ListView.builder(
              reverse: false,
              physics: BouncingScrollPhysics(),
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                return scancard1[index];
              },
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            );
          },
        );
      },
    );
  }
}

Widget topCardWidget({String name}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: 15),
      Text(
        'NAME: $name',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget bottomCardWidget({int adharNumber}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'Aadhar Number: $adharNumber',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
