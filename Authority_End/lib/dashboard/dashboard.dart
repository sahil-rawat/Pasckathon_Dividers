import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../components/messagelist.dart';
import '../components/speech.dart';
import '../components/faq.dart';
import '../components/fine_collected.dart';
import '../login/log_in.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:animated_widgets/animated_widgets.dart';
import '../components/scan_results.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  static const String id = "Main Screen";

  // ignore: non_constant_identifier_names
  MyHomePage({this.Sign_out_google, this.Uid, this.name});

  // ignore: non_constant_identifier_names
  final Function Sign_out_google;
  final String Uid;
  final String name;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  String camerScanResult;
  String dateFormat = "";
  String name = "";
  String adhar = "";
  int startnameindex;
  int endnameindex;
  int startadharindex;
  int endadharindex;
  int n = 0;
  Firestore _firestore = Firestore.instance;

  Future _scanQR() async {
    try {
      camerScanResult = await scanner.scan();
      RegExp re1 = new RegExp(r'https://');
      RegExp re2 = new RegExp(r'http://');
      Match resultMatch1 = re1.matchAsPrefix(camerScanResult);
      Match resultMatch2 = re2.matchAsPrefix(camerScanResult);
      setState(() {
        if (resultMatch1 != null || resultMatch2 != null) {
          result = camerScanResult;
          setState(() {
            _enabled_qrscan = !_enabled_qrscan;
          });
          _launchURL(header: '');
          Alert(
            context: context,
            type: AlertType.error,
            title: "INVALID QR SCAN",
            desc: "WRONG QR CODE",
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                onPressed: () => Navigator.pop(context),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              )
            ],
          ).show();
        } else {
          result = camerScanResult;
          setState(
            () {
              try {
                _enabled_qrscan = !_enabled_qrscan;
                startnameindex = result.indexOf('#');
                endnameindex = result.lastIndexOf('#');
                name = result.substring(startnameindex + 1, endnameindex);
                startadharindex = result.indexOf('&');
                endadharindex = result.lastIndexOf('&');
                adhar = result.substring(startadharindex + 1, endadharindex);
                print(adhar);
                print(name);
                addscanname();
                if (result
                    .contains(new RegExp(dateFormat, caseSensitive: false))) {
                  print(true);
                  Alert(
                    context: context,
                    type: AlertType.success,
                    title: "SUCCESS:CORRECT DAY",
                    desc: "Name : $name \n Aadhar No : $adhar",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        onPressed: () => Navigator.pop(context),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0)
                        ]),
                      )
                    ],
                  ).show();
                } else {
                  print(false);
                  addfinename();
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "FINE!:WRONG DAY",
                    desc: "Name : $name \n Aadhar No : $adhar ",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        onPressed: () => Navigator.pop(context),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0)
                        ]),
                      )
                    ],
                  ).show();
                }
              } catch (e) {
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "INVALID QR SCAN",
                  desc: "WRONG QR CODE",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      onPressed: () => Navigator.pop(context),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
              }
            },
          );
        } // setting string result with cameraScanResult
      });
    } on PlatformException catch (e) {
      if (e.code == scanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $e";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  void addscanname() {
    _firestore
        .collection('scan')
        .document(widget.Uid)
        .updateData({'ID': widget.Uid}).then((value) {
      _firestore
          .collection('scan')
          .document(widget.Uid)
          .collection(widget.Uid)
          .add({
        'name': name,
        'adhar': int.parse(adhar),
      });
    });
  }

  void addfinename() {
    _firestore
        .collection('fine')
        .document(widget.Uid)
        .updateData({'ID': widget.Uid}).then((value) {
      _firestore
          .collection('fine')
          .document(widget.Uid)
          .collection(widget.Uid)
          .add({
        'name': name,
        'adhar': int.parse(adhar),
      });
    });
  }

  _launchURL({String header}) async {
    String url = header + camerScanResult.trim();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // ignore: non_constant_identifier_names
  bool _enabled_qrscan = false;

  // ignore: non_constant_identifier_names
  bool _enabled_FAQs = false;

  // ignore: non_constant_identifier_names
  bool _enabled_TotalScans = false;

  // ignore: non_constant_identifier_names
  bool _enabled_FineCollected = false;
  bool _report = false;
  bool _message = false;

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
            elevation: 80,
            leading: Center(
                child: new Text(
              "👮🏼‍",
              style: TextStyle(fontSize: 30),
            )),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  widget.Sign_out_google();
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
                              Navigator.pushNamed(context, LogIn.id);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 25,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
            title: Center(child: Text("DASHBOARD")),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _enabled_qrscan = !_enabled_qrscan;
                        });
                        _scanQR();
                      },
                      child: ScaleAnimatedWidget.tween(
                        enabled: _enabled_qrscan,
                        scaleEnabled: 2,
                        scaleDisabled: 1,
                        duration: Duration(milliseconds: 200),
                        child: new Container(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Qr Scan',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.qrcode,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                          height: 130,
                          width: 130,
                          margin: new EdgeInsets.only(left: 10.0, right: 10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF333366),
                            shape: BoxShape.rectangle,
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 10,
                                offset: new Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _enabled_TotalScans = !_enabled_TotalScans;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanPage(
                                Sign_out: widget.Sign_out_google,
                                Uid: widget.Uid,
                                name: widget.name,
                              ),
                            ));
                      },
                      child: ScaleAnimatedWidget.tween(
                        enabled: _enabled_TotalScans,
                        scaleEnabled: 2,
                        scaleDisabled: 1,
                        duration: Duration(milliseconds: 200),
                        child: new Container(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Total',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Scans',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          height: 130.0,
                          width: 130.0,
                          margin: new EdgeInsets.only(left: 10.0, right: 10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: new Color(0xFF333366),
                            shape: BoxShape.rectangle,
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 10,
                                offset: new Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _enabled_FineCollected = !_enabled_FineCollected;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FinePage(
                                      Sign_Out: widget.Sign_out_google,
                                      Uid: widget.Uid,
                                      name: widget.name,
                                    )));
                      },
                      child: ScaleAnimatedWidget.tween(
                        enabled: _enabled_FineCollected,
                        scaleEnabled: 2,
                        scaleDisabled: 1,
                        duration: Duration(milliseconds: 200),
                        child: new Container(
                          child: Center(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Fine',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Collected',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          height: 130.0,
                          width: 130.0,
                          margin: new EdgeInsets.only(left: 10.0, right: 10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: new Color(0xFF333366),
                            shape: BoxShape.rectangle,
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 10,
                                offset: new Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _enabled_FAQs = !_enabled_FAQs;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FAQ(
                              Sign_out_google: widget.Sign_out_google,
                              name: widget.name,
                              Uid: widget.Uid,
                            ),
                          ),
                        );
                      },
                      child: ScaleAnimatedWidget.tween(
                        enabled: _enabled_FAQs,
                        scaleEnabled: 2,
                        scaleDisabled: 1,
                        duration: Duration(milliseconds: 200),
                        child: new Container(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "FAQ's",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.question,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                          height: 130.0,
                          width: 130.0,
                          margin: new EdgeInsets.only(left: 10.0, right: 10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: new Color(0xFF333366),
                            shape: BoxShape.rectangle,
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 10,
                                offset: new Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                ),
                /*
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ScaleAnimatedWidget.tween(
                      enabled: _report,
                      scaleEnabled: 2,
                      scaleDisabled: 1,
                      duration: Duration(milliseconds: 200),
                      child: RoundIconButton(
                        w: Icon(
                          Icons.report_problem,
                          color: Colors.white,
                        ),
                        onpress: () {
                          setState(() {
                            _report = !_report;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpeechScreen(
                                        Sign_Out: widget.Sign_out_google,
                                        Uid: widget.Uid,
                                        name: widget.name,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ScaleAnimatedWidget.tween(
                      enabled: _message,
                      scaleEnabled: 2,
                      scaleDisabled: 1,
                      duration: Duration(milliseconds: 200),
                      child: RoundIconButton(
                        w: Icon(
                          FontAwesomeIcons.facebookMessenger,
                          color: Colors.white,
                        ),
                        onpress: () {
                          setState(() {
                            _message = !_message;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Message(
                                        Uid: widget.Uid,
                                        Sign_Out: widget.Sign_out_google,
                                      )));
                        },
                      ),
                    )
                  ],
                ),
              ),
              */
              ],
            ), // Here the scanned result will be shown
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton.extended(
              onPressed: null,
              label: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ScaleAnimatedWidget.tween(
                      enabled: _report,
                      scaleEnabled: 2,
                      scaleDisabled: 1,
                      duration: Duration(milliseconds: 200),
                      child: RoundIconButton(
                        w: Icon(
                          Icons.report_problem,
                          color: Colors.white,
                        ),
                        onpress: () {
                          setState(() {
                            _report = !_report;
                            print(widget.name);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpeechScreen(
                                        Sign_Out: widget.Sign_out_google,
                                        Uid: widget.Uid,
                                        name: widget.name,
                                      )));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ScaleAnimatedWidget.tween(
                      enabled: _message,
                      scaleEnabled: 2,
                      scaleDisabled: 1,
                      duration: Duration(milliseconds: 200),
                      child: RoundIconButton(
                        w: Icon(
                          FontAwesomeIcons.facebookMessenger,
                          color: Colors.white,
                        ),
                        onpress: () {
                          setState(() {
                            _message = !_message;
                            print(widget.name);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Message(
                                        Uid: widget.Uid,
                                        Sign_Out: widget.Sign_out_google,
                                        name: widget.name,
                                      )));
                        },
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.brown.shade300,
              elevation: 0,
              highlightElevation: 10,
            ),
          )),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    DateTime date = DateTime.now();
    dateFormat = DateFormat('EEEE').format(date);
    debugPrint(dateFormat);
    print(widget.Uid);
  }
}

class RoundIconButton extends StatelessWidget {
  @override
  RoundIconButton({this.w, this.onpress});

  final Widget w;
  final Function onpress;

  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: w,
      onPressed: onpress,
      elevation: 6,
      constraints: BoxConstraints.tightFor(
        width: 70,
        height: 70,
      ),
      shape: CircleBorder(),
      fillColor: Colors.redAccent,
    );
  }
}
