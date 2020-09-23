import 'package:flutter/material.dart';
import 'asset.dart';
import 'base_dialog.dart';

class daysCard extends StatelessWidget {
  daysCard({this.day1,this.day2,this.day3});
  final String day1;
  final String day2;
  final String day3;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,builder: (_) => AssetGiffyDialog(

                  image: Image.asset('background.jpg',fit: BoxFit.cover,),
                  title: Text('Travel On $day1',
                    style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  description: Text('You can travel on $day2 in any of the public transport like local trains, bus and metro.\nAlso install Aarogya Setu app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                  entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                  onOkButtonPressed: () {
                    Navigator.pop(context);
                  },
                ) );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue[100],
                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        day1,
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,builder: (_) => AssetGiffyDialog(

                  image: Image.asset('background.jpg',fit: BoxFit.cover,),
                  title: Text('Travel On $day2',
                    style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  description: Text('You can travel on $day2 in any of the public transport like local trains, bus and metro.\nAlso install Aarogya Setu app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                  entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                  onOkButtonPressed: () {
                    Navigator.pop(context);
                  },
                ) );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.brown[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        day2,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,builder: (_) => AssetGiffyDialog(

                  image: Image.asset('background.jpg',fit: BoxFit.cover,),
                  title: Text('Travel On $day3',
                    style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  description: Text('You can travel on $day3 in any of the public transport like local trains, bus and metro.\nAlso install Aarogya Setu app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                  entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                  onOkButtonPressed: () {
                    Navigator.pop(context);
                  },
                ) );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        day3,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}