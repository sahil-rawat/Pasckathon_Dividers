import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../components/profile.dart';
import '../components/faq.dart';
import '../algorithm/algorithm.dart';
import '../components/constants.dart';
import '../components/dayscard.dart';
import '../components/qrcodegenerator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/tipcard.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
  Dashboard(
      {@required this.signOutGoogle,
        @required this.aadharNumber,
        @required this.user});
  final Function signOutGoogle;
  final String aadharNumber;
  final FirebaseUser user;

}

class _DashboardState extends State<Dashboard> {
  Algorithm day = new Algorithm();
  List days = ["a","b","c"];
  final List<String> imageList = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday",];
  Position currentPosition;
  Geoflutterfire geo = new Geoflutterfire();
  Firestore firestore = Firestore.instance;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  DocumentReference doc;
  String totalPeopleAround = "0";
  Color containerColor = Colors.green;
  String containerText1 = "You are Safe";
  String containerText2 = "Less People Around You";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      days = day.getDays(widget.aadharNumber);
    });

  }

  //Functionality methods
  Future<void> _getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
    GeoFirePoint myLocation = geo.point(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude);

    doc = await firestore.collection('UserLocation').add({
      'Position': myLocation.data
    });
    print("LOCATION ADDED");
    areYouSafe();
  }
  Future<void> areYouSafe() async {
    try {
      if (currentPosition != null) {
        GeoFirePoint center = geo.point(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);
        var collectionReference = firestore.collection('UserLocation');
        double radius = 0.1;
        String field = 'Position';
        Stream<List<DocumentSnapshot>> stream = geo
            .collection(collectionRef: collectionReference)
            .within(center: center, radius: radius, field: field);


        stream.listen((List<DocumentSnapshot> documentList) async {
          // doSomething()
          setState(() {
            totalPeopleAround = documentList.length.toString();
          });
          if (documentList.length > 100) {
            print("Entered");
            print("${documentList.length}");
            setState(() {
              containerColor = Colors.red;
              containerText1 = "You are not safe";
              containerText2 = "More people around you";
            });
          }
          Timer.periodic(Duration(seconds: 360), (Timer) {
            var docref = firestore
                .collection("UserLocation")
                .document(doc.documentID);
            docref.get().then((doc) {
              if (doc.exists) {
                firestore
                    .collection("UserLocation")
                    .document(doc.documentID)
                    .delete();
              }
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                Dashboard(signOutGoogle: widget.signOutGoogle,
                    aadharNumber: widget.aadharNumber,
                    user: widget.user)));
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  //UI/UX components.
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            onTap: ()async {
              //widget.signOutGoogle();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text("Alert"),
                    content: Text("Google Account Logged out"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Close"),
                        onPressed: () {
                          Phoenix.rebirth(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: Icon(
              //FontAwesomeIcons.signOutAlt,
              FontAwesomeIcons.signOutAlt,
              size: 25,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
        title: Text("Travel Solutions",style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.idCard),
                          color: Colors.black54,
                          iconSize: 35,
                          onPressed: (){
                            //TODO: DO;


                            String phNo;
                            if(widget.user.phoneNumber == null){
                              setState(() {
                                phNo = "Number Not Provided";
                              });

                            }else{
                              setState(() {
                                phNo = widget.user.phoneNumber;
                              });

                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileCard(user: widget.user,aadharNumber: widget.aadharNumber,phNo: phNo)));
                          }
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF232b2b),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.peopleArrows),
                          color: Colors.blue,
                          iconSize: 35,
                          onPressed: (){
                            //TODO: DO;
                            if(int.parse(totalPeopleAround) < 200){
                              Alert(context:context, title: "You are Safe!",desc: "There are only ${(int.parse(totalPeopleAround)).toString()} around you.").show();
                            }else{
                              Alert(context:context,title: "You are not Safe!",desc: "There are ${(int.parse(totalPeopleAround)).toString()} around you.").show();
                            }

                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'People Nearby',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF232b2b),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.question),
                          color: Colors.black54,
                          iconSize: 35,
                          onPressed: (){
                            //TODO: DO;
                            _getCurrentLocation();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "FAQ's",
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF232b2b),
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Container(
              color: containerColor,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          child: Center(
                              child: Text(
                                '👨🏻‍',
                                style: TextStyle(fontSize: 35.0),
                              )),
                          decoration: kInnerDecoration,
                        ),
                      ),
                      height: 80.0,
                      width: 80.0,
                      decoration: kGradientBoxDecoration,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              containerText1,
                              style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              containerText2,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(child: Text('Days Alloted To Travel', style: kHeadingStyle)),
            SizedBox(
              height: 10.0,
            ),
            daysCard(
              day1: days[0],
              day2: days[1],
              day3: days[2],
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: Text('We Recommend', style: kHeadingStyle)),

            SizedBox(
              height: 20.0,
            ),

            socialtips(
              title: "Maintain proper distance don't overcrowd.",
              image: 'images/4.jpg',
            ),
            covidTips(
              image: 'images/3.jpg',
              title: 'Keep 2-3 seat distance in metro.',
            ),
            socialtips(
              title: 'Wear a mask in a flight.',
              image: 'images/2.jpg',
            ),
            covidTips(
              image: 'images/1.jpg',
              title: 'Sit alone in a bus ride.',
            ),
            SizedBox(
              height: 10.0,
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QrCodeGenerator(
                    name: widget.user.displayName,
                    aadharNumber: widget.aadharNumber,
                    days: days,
                  )));
        },
        tooltip: 'Show this QR to the Respective Authorites.',
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(FontAwesomeIcons.qrcode,color: Colors.white,),
      ),
    );
  }
}














