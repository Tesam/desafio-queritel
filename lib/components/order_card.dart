import 'package:desafio_queritel/screens/order_detail.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final double price;
  final String date;

  const OrderCard({Key key, this.orderId, this.date, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                  child: Text(
                'Order: ' + orderId,
                style: TextStyle(
                  color: PRIMARY,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Price: ' + price.toString() + ' USD')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Date: ' + date)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: InkWell(
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: TEXT,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetail(
                                orderId: orderId,
                              )));
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
