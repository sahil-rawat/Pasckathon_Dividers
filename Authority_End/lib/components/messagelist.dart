import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:time_formatter/time_formatter.dart';
import 'messagecard.dart';
import '../dashboard/dashboard.dart';

class Message extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Function Sign_Out;
  // ignore: non_constant_identifier_names
  final String Uid;
  final String name;
  Message({this.Uid, this.Sign_Out, this.name});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  MessageData m = new MessageData();
  Position currentPosition;
  Firestore _firestore = Firestore.instance;
  double Lat;
  double Long;
  GeoFirePoint center;
  Geoflutterfire geo = Geoflutterfire();

  Future<void> _getCurrentLocation() async {
    currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      Lat = currentPosition.latitude;
      Long = currentPosition.longitude;
    });
    center = geo.point(latitude: Lat, longitude: Long);
    var CollectionReference = _firestore.collection('speech');
    double radius = 0.2;
    String field = 'location';
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: CollectionReference)
        .within(center: center, radius: radius, field: field);
    stream.listen((List<DocumentSnapshot> documentList) {
      // doSomething()
      setState(() {
        m.messagedata = [];
      });
      _firestore.settings();
      var currentTime = DateTime.now();
      for (int i = 0; i < documentList.length; i++) {
        Timestamp time = documentList[i].data['time'];
        var t = new DateTime.fromMillisecondsSinceEpoch(
            time.millisecondsSinceEpoch);
        String name = documentList[i].data['name'];
        String speech = documentList[i].data['speech'];
        var diffDt = currentTime.difference(t);
        String formatted = formatTime(time.millisecondsSinceEpoch);
        print(formatted);
        int min = diffDt.inMinutes;
        int sec = diffDt.inSeconds;
        if (diffDt.inDays == 0 &&
            diffDt.inHours == 0 &&
            diffDt.inMinutes <= 15) {
          m.messagedata
              .add(M(time: formatted, name: name, Speech: speech, min: min,sec: sec));
        }
      }
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
  } // ignore: missing_return

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
      child: Scaffold(
        backgroundColor: Colors.brown.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.brown,
          leading: Center(
              child: new Text(
            "👮🏼‍",
            style: TextStyle(fontSize: 30),
          )),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                "Messages",
                textAlign: TextAlign.left,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Total:' + m.messagedata.length.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MessageCard(
              name: m.messagedata[index].name,
              speech: m.messagedata[index].Speech,
              time: m.messagedata[index].time,
              min: m.messagedata[index].min,
              sec: m.messagedata[index].sec,
            );
          },
          itemCount: m.messagedata.length,
        ),
      ),
      onWillPop: _onBackPressed,
    );
  }
}

class M {
  final String name;
  final String time;
  final String Speech;
  final int sec;
  final int min;
  M({this.time, this.name, this.Speech, this.min,this.sec});
}

class MessageData {
  List<M> messagedata = [];
}
