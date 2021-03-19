import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rawinpornshop/models/user_authen_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/utility/normal_dialog.dart';
import 'package:rawinpornshop/widget/my_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;
  bool redEye = true;
  bool showProgress = false;

  TextEditingController textEditController = TextEditingController();
  FocusNode focusNote = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNote.addListener(() {
      if (focusNote.hasFocus) {
        print('You tap TextFormField');
      }
    });

    readUser();
  }

  Future<Null> readUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var result = preferences.getString('User');

      if (result != null) {
        setState(() {
          user = result.toString();
          print('user readUser ==>> $user');
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildLogin(context),
      body: Stack(
        children: [
          buildContent(),
          showProgress ? MyStyel().showProgress() : SizedBox(),
        ],
      ),
    );
  }

  Container buildLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30, bottom: 30),
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            showProgress = true;
          });
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            setState(() {
              showProgress = false;
            });
            normalDialog(context, 'มีช่องว่าง ? กรุณากรอกทุกช่อง คะ');
          } else {
            checkAuthen();
          }
        },
        child: Icon(Icons.forward, size: 36, color: Colors.white),
      ),
    );
  }

  Container buildContent() {
    return Container(
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
    );
  }

  Future routeToService(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyService(),
        ),
        (route) => false);
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
        // focusNode: focusNote,
        // controller: textEditController,
        key: Key(user == null ? '' : user),
        initialValue: user == null ? '' : user,
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_box),
          contentPadding: EdgeInsets.only(left: 15, top: 7),
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
        obscureText: redEye,
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            // color: Colors.black45,
          ),
          contentPadding: EdgeInsets.only(left: 15, top: 7),
          hintText: 'Password :',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: redEye ? Colors.black45 : Colors.blue[700],
            ),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String urlCheckUser = '${MyConstant().domain}/webapi3/api/user?code=$user';

    await Dio().get(urlCheckUser).then(
      (value) async {
        print(
            '#########################  value ===>> $value #####################');
        if (value.toString() == '[]') {
          setState(() {
            showProgress = false;
          });
          normalDialog(context, 'ไม่มี $user ในฐานข้อมูล ของเรา');
        } else {
          for (var json in value.data) {
            UserAuthenModel model = UserAuthenModel.fromJson(json);
            String passwordKey = model.password;
            print('passwordKey ==>> $passwordKey');

            String path =
                '${MyConstant().domain}/webapi3/api/login?type=0&key=$password';
            await Dio().get(path).then((value) {
              String passwordKey2 = value.data['Passvalue'];
              print('passwordKey2 ==>> $passwordKey2');

              if (passwordKey == passwordKey2) {
                // routeToService(context);
                saveUser();
              } else {
                setState(() {
                  showProgress = false;
                });
                normalDialog(context, 'Password ไม่ถูกต้อง กรุณาลองใหม่ คะ');
              }
            });
          }
        }
      },
    ).catchError((onError) {
      print('########onError#########');
      setState(() {
        showProgress = false;
      });
      normalDialog(
          context, 'กรุณาลองใหม่ ? ไม่สามารถ ติดต่อ Server ได้ในขณะนี้');
    });
  }

  Future<Null> saveUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('User', user);
    routeToService(context);
  }
}
