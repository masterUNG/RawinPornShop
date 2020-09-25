import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';
import 'package:rawinpornshop/utility/normal_dialog.dart';
import 'package:rawinpornshop/widget/product_mis.dart';

class DetailProduct extends StatefulWidget {
  final SearchModel searchModel;
  DetailProduct({Key key, this.searchModel});
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  SearchModel model;
  List<PLs> plss = List();
  bool statusProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
    readPLs();
  }

  Future<Null> readPLs() async {
    var objPLs = model.pLs;
    print('objPLs ==>> ${objPLs.toString()}');

    for (var plsModel in objPLs) {
      Map<String, dynamic> map = plsModel.toJson();
      PLs pLs = PLs.fromJson(map);

      String testPrice = pLs.price9;
      if (testPrice.isNotEmpty) {
        double douTestPrice = double.parse(testPrice);

        if (douTestPrice != 0) {
          setState(() {
            plss.add(pLs);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้า Rawinporn'),
        actions: [barCodeButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyStyel().mySizedBox16(),
            buildText(context, model.code, model.name),
            MyStyel().mySizedBox16(),
            showListPLs(),
            MyStyel().mySizedBox16(),
            showPicture(),
            MyStyel().mySizedBox16(),
            buildTabHost(),
          ],
        ),
      ),
    );
  }

  Widget barCodeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Icon(Istos.shopping_barcode),
            onPressed: () {
              qrThread();
            },
          ),
        ),
      ],
    );
  }

  Widget buildTabHost() {
    List<Widget> widgets = [
      ProductMis(
        searchModel: model,
        whid: MyConstant().whidLatkabang,
      ),
      ProductMis(
        searchModel: model,
        whid: MyConstant().whidEuamp,
      ),
      ProductMis(
        searchModel: model,
        whid: MyConstant().whidNongjok,
      ),
      ProductMis(
        searchModel: model,
        whid: MyConstant().whidHunjakai,
      )
    ];
    List<Widget> tabWidgets = [
      buildText1('ลาดกะบัง', Icons.business),
      buildText1('ตลาดเอี่ยม', Icons.contact_mail),
      buildText1('หน่องจอก', Icons.access_alarms),
      buildText1('หัวจะเข้', Icons.font_download)
    ];

    return Container(
      height: 400,
      child: DefaultTabController(
        length: widgets.length,
        child: Scaffold(
          appBar: TabBar(
              tabs: tabWidgets,
              labelColor: Colors.blue.shade900,
              indicatorColor: Colors.blue,
              // indicatorWeight: 6,
            ),
          body: TabBarView(children: widgets),
        ),
      ),
    );
  }

  Widget buildText1(String string, IconData icons) => Column(
        children: [
          Icon(icons),
          Text(string),
        ],
      );

  Widget buildText(BuildContext context, String string, String string2) {
    return Card(
      color: Colors.orange.shade200,
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  string,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8 - 20,
                  child: Text(
                    string2,
                    style: TextStyle(color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showListPLs() {
    return Card(
      child: Container(
        // padding: EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: <Widget>[
            Container(
              height: 35,
              decoration: BoxDecoration(color: Colors.orange.shade700),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      'BarCode',
                      style: MyStyel().titleH3White(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'หน่วยนับ',
                      style: MyStyel().titleH3White(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'ราคา',
                      style: MyStyel().titleH3White(),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: plss.length,
              itemBuilder: (context, index) => Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(plss[index].barcode),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(plss[index].unitName),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(setupPrice(plss[index].price9)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String setupPrice(String price9) {
    String result;

    if (price9.isEmpty) {
      result = '-';
    } else {
      double priceDou = double.parse(price9.trim());

      if (priceDou == 0) {
        result = '-';
      } else {
        var myFormat = NumberFormat('#,###', 'en_US');
        result = myFormat.format(priceDou);
      }
    }

    return result;
  }

  Widget showPicture() {
    // Uint8List uint8list = base64Decode(model.pic4);

    List<Uint8List> uint8Lists = List();

    List<String> picStrings = [model.pic1, model.pic2, model.pic3, model.pic4];
    for (var string in picStrings) {
      if (string.isNotEmpty) {
        uint8Lists.add(base64Decode(string));
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Swiper(
        itemCount: uint8Lists.length,
        itemBuilder: (context, index) => Image.memory(uint8Lists[index]),
        pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }

  Future<Null> qrThread() async {
    try {
      var object = await BarcodeScanner.scan();
      String qrCode = object.rawContent;
      if (qrCode.isNotEmpty) {
        String url =
            '${MyConstant().domain}/webapi3/api/limit?name=$qrCode&start=1&end=10';
        await Dio().get(url).then((value) {
          if (value.toString() == '[]') {
            normalDialog(context, 'ไม่มี QRcode นี่ใน ฐานข้อมูลของเรา');
          } else {
            for (var map in value.data) {
              SearchModel searchModel = SearchModel.fromJson(map);
              setState(() {
                model = searchModel;
              });
            }
          }
        });
      }
    } catch (e) {}
  }
}
