import 'package:desafio_queritel/screens/item_list.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:desafio_queritel/logic/cart_item_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        child: MaterialApp(
          title: 'Desafío Queritel',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: ItemList(),),
        bloc: CartItemBloc());

  }
}
