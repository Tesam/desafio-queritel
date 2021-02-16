import 'package:desafio_queritel/components/item_card.dart';
import 'package:desafio_queritel/logic/bloc.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final bloc = Block();

  @override
  void initState() {
    super.initState();
    bloc.requestProducts();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: bloc,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF191A32),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2EC8EA), Color(0xFF9CC017)],
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
