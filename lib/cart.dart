import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _cart_card,
          _cart_card,
          _cart_card,
        ],
      )
    );

  }

  final Widget _cart_card = Container(
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
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage('assets/images/product.jpg'),
                    height: 80.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Item name",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),),
                      FittedBox(child: Text(
                        "Item category, weight, price",
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
                      "Quantity",
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
  );
}
