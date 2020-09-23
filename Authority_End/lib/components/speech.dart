import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import '../dashboard/dashboard.dart';

class SpeechScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  SpeechScreen({this.Uid, this.Sign_Out, this.name});

  // ignore: non_constant_identifier_names
  final Function Sign_Out;

  // ignore: non_constant_identifier_names
  final String Uid;
  final String name;

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechRecognition _speechRecognition;
  bool _isListening = false;
  bool _isAvailable = false;
  Position currentPosition;
  double Lat;
  double Long;
  GeoFirePoint mylocation;
  Geoflutterfire geo = Geoflutterfire();

  // ignore: non_constant_identifier_names
  String Speech = "";
  Firestore _firestore = Firestore.instance;
  String _text = 'Press the button and start speaking';

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => _text = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  Future<DocumentReference> _getCurrentLocation() async {
    currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      Lat = currentPosition.latitude;
      Long = currentPosition.longitude;
      mylocation = geo.point(latitude: Lat, longitude: Long);
      return _firestore.collection('speech').add(
        {
          'location': mylocation.data,
          'name': widget.name,
          'speech': Speech,
          'time': DateTime.now(),
        },
      );
    });
  }

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    print(widget.name);
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.brown,
          leading: Center(
              child: new Text(
            "👮🏼‍",
            style: TextStyle(fontSize: 30),
          )),
          actions: <Widget>[
            IconButton(
              color: (_isListening == true) ? Colors.red : Colors.white,
              icon: Icon(Icons.stop),
              onPressed: () async {
                _speechRecognition.stop().then(
                      (result) => setState(() {
                        _isListening = false;
                        Speech = _text;
                        _text = "";
                        _getCurrentLocation();
                      }),
                    );
              },
            )
          ],
          title: Center(
            child: Text(
              "Emergency Message",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: () {
              if (_isAvailable && !_isListening)
                _speechRecognition.listen(locale: "en_US").then(
                      (result) => print('$result'),
                    );
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Center(
                child: Text(
                  _text.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
