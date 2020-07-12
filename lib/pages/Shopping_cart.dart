import 'package:flutter/material.dart';
import 'package:shopping/components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('Fashapp'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      bottomNavigationBar: Container(
          child: Row(
        children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text("Total:"),
            subtitle: Text('\$200'),
          )),
          Expanded(
              child: MaterialButton(
            onPressed: () {},
            child: Text(
              "Check Out",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ))
        ],
      )),
      body: Cart_products(),
    );
  }
}
