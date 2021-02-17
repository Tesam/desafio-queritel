import 'package:desafio_queritel/screens/cart.dart';
import 'package:desafio_queritel/components/item_card.dart';
import 'package:desafio_queritel/logic/bloc.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:desafio_queritel/logic/cart_item_bloc.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final bloc = Block();
  CartItemBloc cartItemBloc;

  @override
  void initState() {
    super.initState();
    bloc.requestProducts();
  }

  Widget build(BuildContext context) {
    cartItemBloc = BlocProvider.of<CartItemBloc>(context);

    return AnimatedBuilder(
        animation: bloc,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: TEXT,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
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
