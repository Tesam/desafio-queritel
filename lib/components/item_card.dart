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
            height: 400,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 200,
                    child: Image.network(
                      "https://cdn.shopify.com/s/files/1/0256/8811/3203/products/1887163200_1_900x.jpg?v=1604998275",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
