import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrcodescanner/dashboard/dashboard.dart';


class LogIn extends StatefulWidget {
  static const String id = "Loginpage";
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final googleSignIn = new GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final usernamecontroller = TextEditingController();
  FirebaseUser User;
  String firebaseUser;
  Future<FirebaseUser> _SignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    User = authResult.user;
    setState(() {
      firebaseUser = User.uid;
    });
    print(" signed in " + User.displayName);
    return User;
  }

  void SignOut() {
    googleSignIn.signOut();
    print('User Signed out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.brown.shade700,
              Colors.brown.shade600,
              Colors.brown.shade500,
              /*
              Color(0xFF1976D2),
              Color(0xFF1976D2),
              Color(0xFF33ADFF),

               */
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: "Hero",
                    child: Center(
                      child: Container(
                        width: 240.0,
                        height: 240.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                              'images/logo.png',
                            ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    "Welcome OnDuty!",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                  child: Center(
                      child: GoogleSignInButton(
                    darkMode: true,
                    onPressed: () {
                      try {
                        _SignIn().then((FirebaseUser user) {
                          _firestore
                              .collection('scan')
                              .document(firebaseUser)
                              .setData(
                            {'ID': firebaseUser},
                          );
                          _firestore
                              .collection('fine')
                              .document(firebaseUser)
                              .setData(
                            {'ID': firebaseUser},
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                      Sign_out_google: SignOut,
                                      Uid: firebaseUser,
                                      name: user.displayName,
                                    )),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("Alert"),
                                  content:
                                      Text("Logged in as ${user.displayName}"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
