import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:rawinpornshop/models/search_model.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  List<SearchModel> searchModels = List();

  @override
  void initState() { 
    super.initState();
    readData();
  }

  Future<void> readData()async{
    String url = 'http://210.86.171.110:89/webapi3/api/limit?name=สลัด&start=1&end=10';
    try {

      Response response = await Dio().get(url);
      print('res ==>> $response');
     
      for (var map in response.data) {
        SearchModel model = SearchModel.fromJson(map);
        setState(() {
          searchModels.add(model);
        });
      }

      
    } catch (e) {
      print('e ==>> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: myContent()),
    );
  }

  Widget showNoSearch() {
    return Center(
      child: Text('Please Fill Search'),
    );
  }

  Widget myContent() => Column(
        children: <Widget>[mySizeBox(), searchBox(), showListResult()],
      );

  Widget showListResult() {
    return searchModels.length == 0
        ? showNoSearch()
        : Expanded(
            child: ListView.builder(
              itemCount: searchModels.length,
              itemBuilder: (context, index) => Text(searchModels[index].name),
            ),
          );
  }

  Row searchBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[barCodeButton(), searchForm(), searchButton()],
    );
  }

  SizedBox mySizeBox() => SizedBox(
        height: 10.0,
      );

  IconButton searchButton() {
    return IconButton(
      icon: Icon(Istos.search),
      onPressed: () {},
    );
  }

  Widget searchForm() => Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(15.0)),
        width: MediaQuery.of(context).size.width - (2 * 58),
        height: 50.0,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.only(
              left: 10.0,
            ),
            border: InputBorder.none,
          ),
        ),
      );

  Widget barCodeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(Istos.shopping_barcode),
          onPressed: () {},
        ),
      ],
    );
  }
}
