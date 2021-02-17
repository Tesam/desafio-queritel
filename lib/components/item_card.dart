import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/logic/cart_item_provider.dart';
import 'package:desafio_queritel/models/cart_table.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  /// Creates a card for product

  /// [category]
  /// [brand]
  /// [title]
  /// [weight]
  /// [weight_label]
  /// [pic_url]
  /// [price]

  final String category;
  final String brand;
  final String title;
  final String weight;
  // ignore: non_constant_identifier_names
  final String weight_label;
  // ignore: non_constant_identifier_names
  final String pic_url;
  final String price;

  const ItemCard(
      {Key key,
      this.category,
      this.brand,
      this.title,
      this.weight,
      // ignore: non_constant_identifier_names
      this.weight_label,
      // ignore: non_constant_identifier_names
      this.pic_url,
      this.price})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  // CartItemBloc cartItemBloc;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _addToCart(CartItemProvider _cartItemProvider) async {
    CartTable productToAdd = CartTable(
      widget.title,
      widget.category,
      widget.brand,
      widget.weight_label,
      'active',
      double.parse(widget.price),
      _counter.toDouble(),
      double.parse(widget.weight),
      widget.pic_url,
    );

    if (_counter > 0) {
      _cartItemProvider.plusBadge();
      await databaseHelper.addCartItem(productToAdd);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _cartItemProvider = Provider.of<CartItemProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    height: 150,
                    child: Image.network(
                      widget.pic_url,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                        color: FIRST_LINEAL_BACKGROUND,
                        onPressed: () {},
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: TEXT,
                              ),
                              onPressed: () {
                                _decrementCounter();
                              },
                            ),
                            Text(_counter.toString(),
                                style: TextStyle(fontSize: 20)),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: TEXT,
                              ),
                              onPressed: () {
                                _incrementCounter();
                              },
                            ),
                          ],
                        )),
                    SizedBox(width: 50), // give it width
                    RaisedButton(
                      onPressed: () {
                        _addToCart(_cartItemProvider);
                      },
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18,
                          color: TEXT,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'USD ' + widget.price,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: TEXT,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.category,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SECONDARY,
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
