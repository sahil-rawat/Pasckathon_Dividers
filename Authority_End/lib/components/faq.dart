import 'package:flutter/material.dart';
import '../dashboard/dashboard.dart';

class FAQ extends StatefulWidget {
  FAQ({this.Sign_out_google, this.name, this.Uid});
  final Function Sign_out_google;
  final String name;
  final String Uid;
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  // ignore: missing_return
  Future<bool> _onBackPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          Sign_out_google: widget.Sign_out_google,
          Uid: widget.Uid,
          name: widget.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.brown.shade300,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Frequently Asked Questions",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "images/cop.jpg",
                  width: 300,
                  fit: BoxFit.cover,
                  height: 300.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.purple[900]),
                    ),
                    color: Colors.purple[100],
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "How?",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "So here all the concerned authorities which are going to be the police will use this app for finding if the people are following the rules by strictly following the alloted days and this will be checked with the help of the qrcode. The concerned authorities will scan the qr code and get the details of the person who's QRcode will be scanned and the people will not be able to trick the police as, if they show the wrong qr code then the error message will be displayed and the police will be able to verify about this and they can fine them.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "images/Crowd.jpg",
                  width: 300.0,
                  fit: BoxFit.cover,
                  height: 300.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: RaisedButton(
                    color: Colors.purple[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.purple[900]),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Features?",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Our app has features such as it will show an alert if there are more number of people in a radius of 50 meteres surrounding you. Also it has the feature to show the QR code to the authority.Also the authorities can use this app as a walkie-talkie. They can record their audio and can call the nearest officials for help if there are any one present in the range of 200 metres. This will be very useful for them as in most cases the users turn violent towards the authorities.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "images/Why.jpg",
                  width: 300.0,
                  fit: BoxFit.cover,
                  height: 300.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.purple[900]),
                    ),
                    color: Colors.purple[100],
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Why?",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Seeing this current Covid-19 situations there has been many problems in starting the public transportation system normally. So we have decided to allot 3 days to the people who wants to travel in a public transport system. By which proper social distancing will be maintained and overcrowding of public transport will be reduced. This app can be further used in many other applications by modifying it, in some way or the other.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
