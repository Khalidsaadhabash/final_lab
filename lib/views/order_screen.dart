import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.order});

  final Map order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Card(
              child: Column(
            children: [
              Text(order["id"].toString()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Title : ${order["title"]}",
                  style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Content : ${order["content"]}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Date : ${order["create_at"]}"),
              ),
            ],
          )),
        ]),
      ),
    );
  }
}
