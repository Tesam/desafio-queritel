import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderDetailCard extends StatefulWidget {
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
  final String quantity;

  const OrderDetailCard(
      {Key key,
      this.category,
      this.brand,
      this.title,
      this.weight,
      // ignore: non_constant_identifier_names
      this.weight_label,
      // ignore: non_constant_identifier_names
      this.pic_url,
      this.price,
      this.quantity})
      : super(key: key);

  @override
  _OrderDetailCardState createState() => _OrderDetailCardState();
}

class _OrderDetailCardState extends State<OrderDetailCard> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
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
                        'Quantity: ' + widget.quantity,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: PRIMARY,
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
