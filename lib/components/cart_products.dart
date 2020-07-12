import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var product_on_cart = [
    {
      "name": "Blazer",
      "picture": "images/product/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
      "color": "Blue",
      "size": 9,
      "qty": 6,
    },
    {
      "name": "Red dress",
      "picture": "images/product/dress1.jpeg",
      "old_price": 100,
      "price": 50,
      "color": 'Red',
      "size": 7,
      "qty": 5,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: product_on_cart.length,
        itemBuilder: (context, index) {
          return Single_product(
            prod_name: product_on_cart[index]["name"],
            prod_old_price: product_on_cart[index]["old_price"],
            prod_price: product_on_cart[index]["price"],
            prod_pricture: product_on_cart[index]["picture"],
            prod_color: product_on_cart[index]["color"],
            prod_size: product_on_cart[index]["size"],
            prod_qty: product_on_cart[index]["qty"],
          );
        });
  }
}

class Single_product extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;
  final prod_size;
  final prod_color;
  final prod_qty;
  Single_product(
      {this.prod_pricture,
      this.prod_old_price,
      this.prod_price,
      this.prod_name,
      this.prod_color,
      this.prod_size,
      this.prod_qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          prod_pricture,
          width: 50,
          height: 100,
        ),
        title: Text(prod_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(prod_size.toString()),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(prod_color),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$$prod_price',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        trailing: Container(
          child: Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: () {}),
              Text(prod_qty.toString()),
              IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
