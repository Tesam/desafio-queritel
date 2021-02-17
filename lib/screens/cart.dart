import 'package:desafio_queritel/models/cart_table.dart';
import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<CartTable> cartTableList;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    loadCartItems();
    // databaseHelper
    //     .activeCartItems(); //just to active all the items in the cart, for tests.
  }

  @override
  Widget build(BuildContext context) {
    final checkoutButton = InkWell(
      onTap: checkout,
      child: Container(
        height: 60.0,
        width: 100.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [FIRST_LINEAL_BACKGROUND_II, SECOND_LINEAL_BACKGROUND_II],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Text(
            "Checkout",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );

    final priceContainer = Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 100.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [FIRST_LINEAL_BACKGROUND, SECOND_LINEAL_BACKGROUND],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Text(
        '${this.totalPrice} \$',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      body: ListView(
        children: [
          loadCartCards(cartTableList),
          priceContainer,
          checkoutButton,
        ],
      ),
    );
  }

  void loadCartItems() async {
    double price = 0;
    Future<List<CartTable>> cartList = databaseHelper.getCartItems('active');
    cartList.then((value) {
      value.forEach((cartItem) {
        price = price +
            cartItem.itemPrice.toDouble() * cartItem.itemQuantity.toDouble();
      });

      setState(() {
        this.cartTableList = value;
        this.totalPrice = price;
      });
    });
  }

  void checkout() async {
    Future<int> addOrder = databaseHelper.addOrder(this.cartTableList);
    Future<int> updates =
        databaseHelper.updateCartItemState(this.cartTableList, 'inactive');
    updates.then((value) => loadCartItems());
  }

  void remove(cartTable) async {
    List<CartTable> listRemove = List<CartTable>();
    listRemove.add(cartTable);

    Future<int> updates =
        databaseHelper.updateCartItemState(listRemove, 'inactive');
    updates.then((value) => loadCartItems());
  }

  Widget loadCartCards(List<CartTable> cartTableList) {
    if (cartTableList == null) {
      return CircularProgressIndicator();
    }

    List<Widget> list = new List<Widget>();
    cartTableList.forEach((cartTable) {
      list.add(
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 220,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      /*Image(
                        image: cartTable.imgUrl.contains('http')
                            ? NetworkImage(cartTable.imgUrl)
                            : null,
                        height: 80.0,
                      ),*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              cartTable.itemName.toString(),
                              style: TextStyle(
                                fontSize: 10.0,
                                color: TEXT,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              '${cartTable.itemCategory.toString()}, ${cartTable.weight.toString()}, Price: ${cartTable.itemPrice.toString()}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: SECONDARY,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => remove(cartTable),
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
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'Quantity:  ' + cartTable.itemQuantity.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: TEXT,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });

    return new Column(children: list);
  }
}
