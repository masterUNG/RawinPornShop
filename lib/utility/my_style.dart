import 'package:flutter/material.dart';

class MyStyel {

  Widget showProgress(){
    return Center(child: CircularProgressIndicator(),);
  }

  TextStyle titleH2() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle titleH2white() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  SizedBox mySizedBox(double height){
    return SizedBox(height: height,);
  }

  MyStyel();
}
