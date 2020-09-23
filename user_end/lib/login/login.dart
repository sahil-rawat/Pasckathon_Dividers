import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validators/validators.dart';
import '../dashboard/dashboard.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

//Login Screen Class.
class _LoginState extends State<Login> {
  final googleSignIn = new GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final usernamecontroller = TextEditingController();
  String aadharNumber =" ";
  TextEditingController aadharNumberController;
  FirebaseUser user;

  //Sign In Function
  Future<FirebaseUser> _SignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    user = authResult.user;
    Firestore.instance.collection("CurrentlyActive")
        .document(aadharNumber)
        .setData({"Name": user.displayName, "Aadhar Number": aadharNumber,"Email":user.email});


    Firestore.instance.collection("TotalRegistered")
        .document(aadharNumber)
        .setData({"Name": user.displayName, "Aadhar Number": aadharNumber,"Email":user.email});
    print(" signed in " + user.displayName);
    return user;
  }

  //Sign Out Function
  void SignOut() async{
    var docRef = Firestore.instance.collection("CurrentlyActive").document(aadharNumber);
    await docRef.get().then((doc){
      if(doc.exists){
        print(user.uid);
        Firestore.instance.collection("CurrentlyActive").document(aadharNumber).delete();
      }
    });
    googleSignIn.signOut();
    print('User Signed out');
  }

  //UI/UX
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color(0xFF1976D2),
                Color(0xFF1976D2),
                Color(0xFF33ADFF),
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
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/playstore.png',
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text("Welcome Aboard!",style: TextStyle(fontSize: 35,color: Colors.white),)),
                    SizedBox(
                      height: 4,
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/2,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60)
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue[800],
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(20),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: aadharNumberController,
                                      maxLength: 12,
                                      maxLengthEnforced: true,

                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter Aadhar Number',

                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          aadharNumber = val;
                                          //you can access nameController in its scope to get
                                          // the value of text entered as shown below
                                          //fullName = nameController.text;
                                        });
                                      },
                                    )),

                                Center(
                                  child: GoogleSignInButton(
                                    darkMode: true,
                                    onPressed: () {
                                      try {
                                        if(aadharNumber.length == 12 && isNumeric(aadharNumber)){
                                          print(aadharNumber);
                                          _SignIn().then((FirebaseUser user) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Dashboard(
                                                    signOutGoogle: SignOut,
                                                    aadharNumber: aadharNumber,
                                                    user: user,
                                                  )),
                                            );
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return CupertinoAlertDialog(
                                                    title: Text("Alert"),
                                                    content: Text(
                                                        "Logged in as ${user.displayName}"),
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
                                        }else if(aadharNumber.length != 12 || isNumeric(aadharNumber)==false){
                                          DangerAlertBoxCenter(context: context,
                                          messageText: "Enter valid 12 digit Aadhar Number");
                                        }

                                      } catch (e) {
                                        print("Hello");
                                        print(e.toString());
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
