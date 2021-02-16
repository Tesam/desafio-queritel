import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  /// Creates a card for product

  /// [category]
  /// [brand]
  /// [title]
  /// [weight]
  /// [weight_label]
  /// [pic_url]
  /// [price]

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    height: 150,
                    child: Image.network(
                      "https://cdn.shopify.com/s/files/1/0256/8811/3203/products/1887163200_1_900x.jpg?v=1604998275",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: const Text('2', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(width: 50), // give it width
                    RaisedButton(
                      onPressed: () {},
                      child: const Text('Add to cart',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nestle Evaporated Milk 330ml',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF191A32),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'USD ' + '2.90',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF191A32),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pantry',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9CC017),
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
