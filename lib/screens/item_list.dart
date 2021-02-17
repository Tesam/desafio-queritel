import 'package:flutter/material.dart';
import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/models/cart_table.dart';
import 'package:desafio_queritel/screens/cart.dart';
import 'package:desafio_queritel/components/item_card.dart';
import 'package:desafio_queritel/logic/bloc.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:badges/badges.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final bloc = Block();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    bloc.requestProducts();
    Future<List<CartTable>> itemsInCart = databaseHelper.getCartItems('active');
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: bloc,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: TEXT,
              leading: GestureDetector(
                onTap: () {/* Write listener code here */},
                child: Icon(
                  Icons.menu, // add custom icons also
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Badge(
                    badgeContent: Text('3'),
                    badgeColor: PRIMARY,
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart()));
                      },
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [FIRST_LINEAL_BACKGROUND, SECOND_LINEAL_BACKGROUND],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: bloc.products.isEmpty
                  ? Center(
                      child: Text('Loading'),
                    )
                  : ListView.builder(
                      itemCount: bloc.products.length,
                      itemBuilder: (_, index) {
                        return ItemCard(
                          title: bloc.products[index].title,
                          brand: bloc.products[index].brand,
                          weight: bloc.products[index].weight,
                          weight_label: bloc.products[index].weight_label,
                          price: bloc.products[index].lider_price.toString(),
                          category: bloc.products[index].category,
                          pic_url: bloc.products[index].pic_url,
                        );
                      },
                    ),
            ),
          );
        });
  }
}
