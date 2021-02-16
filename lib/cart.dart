import 'dart:typed_data';

import 'package:desafio_queritel/utils/cart_table.dart';
import 'package:desafio_queritel/utils/database_helper.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String itemName = '', itemCategory = '';
  double weight = 2.0, itemPrice = 1.0, itemQuantity = 3.0;
  Uint8List imgUrl;

  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  void loadDatabase() async {
    Future<CardTable> todoListFuture = databaseHelper.getInfo('ds');
    todoListFuture.then((value) {
      print('BASE DE DATOS: ${value.itemName}, ${value.itemCategory}, ${value.weight}, ${value.itemPrice}, ${value.itemQuantity}, ${value.imgUrl}');

      setState(() {
        this.itemName = value.itemName;
        this.itemCategory = value.itemCategory;
        this.weight = value.weight;
        this.itemPrice = value.itemPrice;
        this.itemQuantity = value.itemQuantity;
        this.imgUrl = value.imgUrl;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    if (imgUrl == null) {
      return CircularProgressIndicator();
    }

    return Scaffold(
        body: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(10,10,10,0),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child:
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: MemoryImage(imgUrl),
                            height: 80.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  this.itemName.toString(),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),),
                              FittedBox(child: Text(
                                '${this.itemCategory.toString()}, ${this.weight.toString()}, ${this.itemPrice.toString()}',
                                style: TextStyle(
                                    fontSize: 14.0
                                ),
                              ),),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            //onTap:
                            child: Container(
                              height: 40.0,
                              width: 100.0,
                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              this.itemQuantity.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          )
      ],
    ));
  }

}
