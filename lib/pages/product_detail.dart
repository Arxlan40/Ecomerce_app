import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/components/products.dart';
import 'package:shopping/pages/HomePage.dart';
import 'package:shopping/pages/Shopping_cart.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product_detail extends StatefulWidget {
  final prod_detail_name;
  final prod_detail_pricture;
  final prod_detail_old_price;
  final prod_detail_new_price;
  final size_dropdown;
  Product_detail(
      {this.prod_detail_name,
      this.prod_detail_new_price,
      this.prod_detail_old_price,
      this.prod_detail_pricture,
      this.size_dropdown});

  @override
  _Product_detailState createState() => _Product_detailState();
}

class _Product_detailState extends State<Product_detail> {
  String _currentSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Text('Fashapp'),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 300,
                child: GridTile(
                  child: Container(
                    child: Image.asset(
                      (widget.prod_detail_pricture.toString()),
                      width: 140,
                      height: 140,
                    ),
                  ),
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        widget.prod_detail_name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            '\$${widget.prod_detail_old_price}'.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          )),
                          Expanded(
                              child: Text(
                            '\$${widget.prod_detail_new_price}'.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: DropdownButton(
                items: widget.size_dropdown,
                onChanged: (sizevalue) {
                  setState(() {
                    _currentSize = sizevalue;
                  });
                },
                value: _currentSize,
                isExpanded: false,
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Quantity'),
                          content: Text("Select the Quantity"),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "close",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        );
                      });
                },
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('QTY')),
                    Expanded(child: Icon(Icons.arrow_drop_down))
                  ],
                ),
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Color'),
                          content: Text("Select the color"),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "close",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        );
                      });
                },
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('Color')),
                    Expanded(child: Icon(Icons.arrow_drop_down))
                  ],
                ),
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'BuyNow',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
            ],
          ),
          Divider(),
          ListTile(
            title: Text(
              "Product Detail",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,"),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(13, 5, 5, 5),
                child: Text(
                  'Product Name:',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.prod_detail_name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(13, 5, 5, 5),
                child: Text(
                  'Product Brand:',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Brand X",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(13, 5, 5, 5),
                child: Text(
                  'Product Condition:',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'New',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.fromLTRB(13, 5, 5, 5),
              child: Text(
                "Similar Products",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 360,
            child: Products(),
          )
        ],
      ),
    );
  }

  changeSelectedCategory(selectedCategory) {
    setState(() => _currentSize = selectedCategory);
  }
}
