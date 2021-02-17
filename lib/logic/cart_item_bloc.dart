import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/models/cart_table.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CartItemBloc extends Bloc{

  DatabaseHelper databaseHelper = DatabaseHelper();

   Future<int> cartLength() async {

     /*Future<List<CartTable>> cartList = databaseHelper.getCartItems('active');
     cartList.then((value) {
       return value.length;
     });*/

     return await databaseHelper.getCartItems('active').then((value) => value.length);
   }

  @override
  void dispose() {

  }
}