import 'package:desafio_queritel/components/order_detail_card.dart';
import 'package:desafio_queritel/db/database_helper.dart';
import 'package:desafio_queritel/models/order_items_table.dart';
import 'package:desafio_queritel/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final String orderId;

  const OrderDetail({
    Key key,
    this.orderId,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List<OrderItemsTable> orderDetailList;

  @override
  void initState() {
    super.initState();
    Future<List<OrderItemsTable>> orderItemsList =
        DatabaseHelper().getOrderItems(widget.orderId);

    orderItemsList.then(
      (value) => setState(() {
        orderDetailList = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TEXT,
      ),
      body: orderDetailList == null
          ? Center(child: Text('You dont have orders'))
          : Container(
              child: ListView.builder(
                itemCount: orderDetailList.length,
                itemBuilder: (_, index) {
                  return OrderDetailCard(
                    title: orderDetailList[index].itemName,
                    brand: orderDetailList[index].itemBrand,
                    weight: orderDetailList[index].weight.toString(),
                    weight_label: orderDetailList[index].weightLabel,
                    price: orderDetailList[index].itemPrice.toString(),
                    category: orderDetailList[index].itemCategory,
                    pic_url: orderDetailList[index].imgUrl,
                    quantity: orderDetailList[index].itemQuantity.toString(),
                  );
                },
              ),
            ),
    );
  }
}
