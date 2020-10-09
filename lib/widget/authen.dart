import 'package:flutter/material.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/widget/search_product.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 30, bottom: 30),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SearchProduct(),
              ),
              (route) => false),
          child: Icon(Icons.forward, size: 36, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.0,
            colors: [Colors.white, MyStyel().primaryColor],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 24),
                width: 120,
                child: Image.asset('images/logo.png'),
              ),
              buildUser(),
              MyStyel().mySizedBox16(),
              buildPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      width: 250,
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          hintText: 'User :',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      width: 250,
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          hintText: 'Password :',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
