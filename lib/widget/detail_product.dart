import 'package:flutter/material.dart';
import 'package:rawinpornshop/models/search_model.dart';
import 'package:rawinpornshop/utility/my_style.dart';

class DetailProduct extends StatefulWidget {
  final SearchModel searchModel;
  DetailProduct({Key key, this.searchModel});
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  SearchModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.searchModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          buildText(context, 'รหัสสินค้า : ${model.code}'),
          buildText(context, 'ชื่อสินค้า : ${model.name}'),
          learnXd(),
                  ],
                ),
              );
            }
          
            Widget buildText(BuildContext context, String string) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        string,
                        style: MyStyel().titleH2(),
                      ),
                    ),
                  ),
                ],
              );
            }
          
            Widget learnXd() {
              return Stack(
    children: <Widget>[
      Transform.translate(
        offset: Offset(45.0, 103.0),
        child: Container(
          width: 258.0,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 1.0),
              colors: [const Color(0xff1f1688), const Color(0xffdee539)],
              stops: [0.0, 1.0],
            ),
            border: Border.all(width: 1.0, color: const Color(0xff707070)),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(49.0, 228.0),
        child: Container(
          width: 83.0,
          height: 62.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(41.5, 31.0)),
            gradient: RadialGradient(
              center: Alignment(0.0, 0.0),
              radius: 0.5,
              colors: [const Color(0xffe35c5c), const Color(0xff808080)],
              stops: [0.0, 1.0],
              transform: GradientXDTransform(
                  1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
            ),
            border: Border.all(width: 1.0, color: const Color(0xff707070)),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(180.0, 304.0),
        child: Container(
          width: 62.0,
          height: 86.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 1.0),
              colors: [const Color(0xffcdeb29), const Color(0xff677615)],
              stops: [0.0, 1.0],
            ),
            border: Border.all(width: 1.0, color: const Color(0xff707070)),
          ),
        ),
      ),
    ],
  );
            }
}
