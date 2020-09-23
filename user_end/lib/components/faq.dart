import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}


class _FAQState extends State<FAQ> {
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
                "images/Busines.jpg",
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
              child: RaisedButton(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.black54),
              ),
                  color: Colors.white,
                  onPressed: (){},
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("How?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Okay so we will be collecting your Aadhar number on Login and will allot you three days in a week. You are only allowed to travel on these three days and no other day. Disobeying will lead to fines and ofcourse may cause corona. Respective authorities will have a seperate app to whom you can show your QR code and they will get to know your details, and may fine you if you are not travelling on the respective dates.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400),)),
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
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black54),
                  ),
                  onPressed: (){},
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Features?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Our app has features such as it will show an alert if there are more number of people in a radius of 50 meteres surrounding you. Also it has the feature to show the QR code to the authority.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400),)),
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
              child: RaisedButton(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.black54),

              ),
                  color: Colors.white,
                  onPressed: (){},
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Why?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Seeing this current Covid-19 situations there has been many problems in starting the public transportation system normally. So we have decided to allot 3 days to the people who wants to travel in a public transport system. By which proper social distancing will be maintained and overcrowding of public transport will be reduced.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400),)),
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
    );
  }
}




