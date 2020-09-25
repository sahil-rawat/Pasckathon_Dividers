import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';


class QrCodeGenerator extends StatefulWidget {
  QrCodeGenerator({@required this.days,@required this.aadharNumber,@required this.name});
  final List days;
  final String aadharNumber;
  final String name;
  @override
  State<StatefulWidget> createState() => QrCodeGeneratorState();
}

class QrCodeGeneratorState extends State<QrCodeGenerator> {


  GlobalKey globalKey = new GlobalKey();
  String get _dataString{
    return "#${widget.name}# &${widget.aadharNumber}& *${widget.days[0]} ${widget.days[1]} ${widget.days[2]}*";
  }


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
        title: Text("Your QR Code",style: TextStyle(color: Colors.black),),
      ),
      body: _contentWidget(),
    );
  }



  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[
          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.5 * bodyHeight,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }
}