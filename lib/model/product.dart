
import 'package:dingzo/model/myuser.dart';
import 'package:flutter/material.dart';

class Product{
  bool ?banner;
  final String ? id;
   String ? title;
  final List<String> ? photos;
   String ? description;
   double ? price;

  final bool ?rent;
  double ? total;
  int ? quantity;
  final String ? product_doc_id ;
  final String ? category;
  final bool ? status;
  final sellerid;
  final int ? sales;
  final String ? sellername;
  bool ? selected;
  final double ? indiviusal_totalprice;
  final String ? product_status ;
  final DateTime ? date;
   MyUser ? seller;
  final String ? rent_duration;
  final double ? rent_fare;
  final order_id;
  final int ? views;
  final List<Likes>? likes;
   bool ? like_status;
  final bool ? both_service;
  double ? distance;
  Product({@required this.id,@required this.price,@required this.title,@required this.quantity,this.description,this.category,this.product_doc_id,this.status,this.sellerid,this.total,this.sales,this.sellername,this.photos,this.selected,this.indiviusal_totalprice,this.product_status,this.date,this.seller,this.rent,this.rent_duration,this.rent_fare,this.order_id,this.views,this.likes,this.like_status,this.both_service,this.distance,
  this.banner
  });

}
class Likes {

  String? userid;
  bool? status;
  Likes({this.userid, this.status});

}

