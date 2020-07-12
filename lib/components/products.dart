import 'package:flutter/material.dart';
import 'package:shopping/pages/product_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Products_DataBase();
  }
}

class Products_DataBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        List<NetworkImage> _listOfImages = <NetworkImage>[];

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  for (int i = 0;
                      i <
                          snapshot
                              .data.documents[index].data['imageUrl'].length;
                      i++) {
                    _listOfImages.add(NetworkImage(
                        snapshot.data.documents[index].data['imageUrl'][i]));
                  }
                  return Card(
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Product_detail(
                                        prod_detail_name: snapshot.data
                                            .documents[index]['Product Name'],
                                        prod_detail_new_price: snapshot
                                            .data.documents[index]['price'],
                                        prod_detail_old_price: snapshot
                                            .data.documents[index]['quantity'],
                                        prod_detail_pricture: _listOfImages,
                                      )));
                        },
                        child: GridTile(
                            footer: Container(
                              color: Colors.white70,
                              child: ListTile(
                                leading: Text(
                                  snapshot.data.documents[index]
                                      ['Product Name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                title: Text(
                                  snapshot.data.documents[index]['quantity']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800),
                                ),
                                subtitle: Text(
                                  snapshot.data.documents[index]['price']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w800,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                            ),
                            child: Image.network(
                              snapshot.data.documents[index]['imageUrl'][1]
                                  .toString(),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  );
                });
        }
      },
    );
  }
}
