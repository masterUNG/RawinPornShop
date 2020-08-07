import 'package:flutter/material.dart';

class MyStyel {
  Widget buildTitleH2(String string) => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              top: 8,
              bottom: 6,
            ),
            child: Text(string, style: titleH2(),),
          ),
        ],
      );

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  TextStyle titleH2() {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle titleH3() {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle titleH3White() {
    return TextStyle(color: Colors.white,
      fontSize: 14.0,
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

  SizedBox mySizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  SizedBox mySizedBox16() {
    return SizedBox(
      height: 16,
    );
  }

  MyStyel();
}
