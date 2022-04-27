import 'package:flutter/material.dart';
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

  Product({@required this.id,@required this.price,@required this.title,@required this.quantity,this.description,this.category,this.product_doc_id,this.status,this.sellerid,this.total,this.sales,this.sellername,this.brand,this.condition,this.freeshipment,this.photos});
}