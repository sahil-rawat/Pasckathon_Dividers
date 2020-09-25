import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({this.user,this.aadharNumber,this.phNo});
  final FirebaseUser user;
  final String aadharNumber;
  final String phNo;

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
        title: Text("Your Profile",style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: GFAvatar(
                      backgroundImage:NetworkImage(widget.user.photoUrl),
                      shape: GFAvatarShape.standard,
                      size: 120,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: RaisedButton(
                      elevation: 4,
                      onPressed: (){},
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black54),
                      ),
                      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Name:",style:
                                TextStyle(fontFamily: 'DMSans',fontWeight: FontWeight.w500,fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(child: Text(widget.user.displayName, style: TextStyle(fontSize: 14,fontFamily: 'DMSans'),)),
                              ],
                            ),
                          ),
                        ),
                      ],
            ),
            Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Aadhar Number:",style:
                                TextStyle(fontFamily: 'DMSans',fontWeight: FontWeight.w500,fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(child: Text(widget.aadharNumber, style: TextStyle(fontSize: 14,fontFamily: 'DMSans'),)),
                              ],
                            ),
                          ),
                        ),
                      ],
            ),
            Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Email:",style:
                                TextStyle(fontFamily: 'DMSans',fontWeight: FontWeight.w500,fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(child: Text(widget.user.email, style: TextStyle(fontSize: 14,fontFamily: 'DMSans'),)),
                              ],
                            ),
                          ),
                        ),
                      ],
            ),
            Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Phone Number:",style:
                                TextStyle(fontFamily: 'DMSans',fontWeight: FontWeight.w500,fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(child: Text(widget.phNo, style: TextStyle(fontSize: 14,fontFamily: 'DMSans'),)),
                              ],
                            ),
                          ),
                        ),
                      ],
            ),






            ],
          ),
                    ),
                  ),
                ),
              ),
      ],
    ),
        ),
    ),
    );
  }
}
