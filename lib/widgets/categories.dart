import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/widgets/cat_products.dart';
import 'package:ecommerce_user/widgets/loading.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.white,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.data == null) return Loading();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return ListView(
                   shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.docs.map((document) {
                      return Card(
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => CatProducts()));
                            },
                            child: Container(
                              //margin: EdgeInsets.only(bottom: 350),
                              height: 140,
                              width: 120,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      color: Colors.white,
                                      child: Image.network(document['image']),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        document['category'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            );
          }),
    );
  }
}
