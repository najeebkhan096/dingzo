import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class Product{
  final String ? id;
  final String ? title;
  final List<String> ? photos;
  final String ? brand;
  final String ? condition;
  final String ? description;
  final double ? price;
  final bool ? freeshipment;
  double ? total;
  int ? quantity;
  final String ? product_doc_id ;
  final String ? category;
  final bool ? status;
  final sellerid;
  final int ? sales;
  final String ? sellername;
  bool ? selected;

  Product({@required this.id,@required this.price,@required this.title,@required this.quantity,this.description,this.category,this.product_doc_id,this.status,this.sellerid,this.total,this.sales,this.sellername,this.brand,this.condition,this.freeshipment,this.photos,this.selected});
}

class ProductDatabase{
  Future<List<Product>> fetch_products({String ? title}) async {

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        print("step1");
        List<dynamic> photos = fetcheddata['photos'];

        if (fetcheddata['category'] == title) {
          Product new_product = Product(
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              id: element.id,
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id: element.id,
              description: fetcheddata['description'],
              total: 0,
              brand: fetcheddata['brand'],
              selected: false,
              photos:photos
                  .map(
                      (e) => e['imageurl'].toString()
              )
                  .toList(),
              condition: fetcheddata['condition'],
              freeshipment: fetcheddata['freeshipment'],
              sellerid: fetcheddata['seller_id'],

              sales: fetcheddata['sales'],
              sellername: fetcheddata['seller_name'].toString()
          );
          newCategories.add(new_product);
        }

      });
    }).then((value) {
      newCategories.sort((a,b)=>a.sales!.toInt() .compareTo(b.sales!.toInt() ));
      newCategories=newCategories.reversed.toList();
    });

    return newCategories;
  }

  Future uploadProduct({Product ? product})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    imgRef.add({
      'title':product!.title,
      'description': product.description,
      'price':product.price,
      'photos': product.photos!.map(
              (e) => {
            'imageurl': e,
          }).toList(),
      'condition':product.condition,
      'category':product.category,
      'status':true,
      'seller_id':product.sellerid,
      'seller_name':product.sellername,
      'sales':product.sales,
      'brand':product.brand,
      'freeshipment':product.freeshipment,

    });
  }



}