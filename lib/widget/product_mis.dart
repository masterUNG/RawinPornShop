import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rawinpornshop/models/productmis_model.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_constant.dart';
import 'package:rawinpornshop/utility/my_style.dart';

class ProductMis extends StatefulWidget {
  final SearchModel searchModel;
  final String whid;
  ProductMis({Key key, this.searchModel, this.whid}) : super(key: key);
  @override
  _ProductMisState createState() => _ProductMisState();
}

class _ProductMisState extends State<ProductMis> {
  String whid;
  int pid;
  SearchModel model;
  ProductMISmodel productMISmodel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
    if (model != null) {
      print('data model == ${model.name}');
    } else {print('model null#############');}
    pid = model.id;
    whid = widget.whid;

    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productMISmodel == null
          ? MyStyel().showProgress()
          : Center(
              child: model == null ? Text('No Data') : Column(
                children: [
                  MyStyel().showProductMIS('Stock คงเหลือ =',
                      productMISmodel.stkWh, Colors.purple.shade700),
                  MyStyel().showProductMIS('วันที่รับเข้าล่าสุด =',
                      productMISmodel.reciveLastQty, Colors.purple.shade700),
                  MyStyel().showProductMIS('จำนวนรับเข้า =',
                      productMISmodel.reciveLastQty, Colors.purple.shade700),
                  MyStyel().showProductMIS('ขายหลังรับเข้าล่าสุด =',
                      productMISmodel.saleAfterRC, Colors.purple.shade700),
                  MyStyel().showProductMIS('วันที่ขายล่าสุด =',
                      productMISmodel.saleLastDate, Colors.purple.shade700),
                ],
              ) ,
            ),
    );
  }

  Future<Null> readData() async {
    String urlProductMIS =
        '${MyConstant().domain}/webapi3/api/productmis?pid=$pid&whid=$whid';
    await Dio().get(urlProductMIS).then((value) {
      // print('value ==> $value');
      setState(() {
        productMISmodel = ProductMISmodel.fromJson(value.data);
      });
      // print('Recive ==> ${productMISmodel.reciveLastDate}');
    });
  }
}
