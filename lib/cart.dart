import 'package:desafio_queritel/utils/cart_table.dart';
import 'package:desafio_queritel/utils/database_helper.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<CartTable> cardTableList;

  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  void loadDatabase() async {
    Future<List<CartTable>> cartList = databaseHelper.getCartItems('active');
    cartList.then((value) {
      setState(() {
        this.cardTableList = value;
      });
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loadCartCards(cardTableList),
    );
  }

  Widget loadCartCards(List<CartTable> cartTableList){

    if (cartTableList == null) {
      return CircularProgressIndicator();
    }

    List<Widget> list = new List<Widget>();
    cartTableList.forEach((cartTable) {

      list.add(
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
                            image: MemoryImage(cartTable.imgUrl),
                            height: 80.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  cartTable.itemName.toString(),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),),
                              FittedBox(child: Text(
                                '${cartTable.itemCategory.toString()}, ${cartTable.weight.toString()}, ${cartTable.itemPrice.toString()}',
                                style: TextStyle(
                                    fontSize: 16.0
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
                                      fontSize: 16.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              cartTable.itemQuantity.toString(),
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
      );
    });

    return new Column(children: list);
  }

}
