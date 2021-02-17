import 'package:desafio_queritel/models/cart_table.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';

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

  void _addToCart() {
    print('Transformando product to cartTable');
    print(widget.title);
    print(widget.category);
    print(widget.price);
    print(widget.pic_url);
    print(_counter);

    // CartTable productToadd = CartTable(widget.title, widget.category, 'Nestle', '50oz', 'Active', 10, widget.price, _counter.toDouble(), _weight, )
  }

  @override
  Widget build(BuildContext context) {
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
                        _addToCart();
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
