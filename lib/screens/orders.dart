import 'package:desafio_queritel/components/order_card.dart';
import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/models/order_table.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Future<List<OrderTable>> promiseOrderList;
  List<OrderTable> orderList;

  @override
  void initState() {
    super.initState();
    promiseOrderList = databaseHelper.getOrders();
    promiseOrderList.then(
      (value) => setState(() {
        orderList = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TEXT,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffE5E5E5),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My orders',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: TEXT,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Find here your current and past orders',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                  color: TEXT,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: orderList == null
                  ? CircularProgressIndicator()
                  : Container(
                      child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (_, index) {
                          return OrderCard(
                            orderId: orderList[index].id.toString(),
                            price: orderList[index].price,
                            date: orderList[index].date,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
