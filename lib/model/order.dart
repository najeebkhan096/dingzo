import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  List<Product> ? products;
  double ? total_price;
  String ? notes;
  String ? date;
  String ? userid;
  String ? order_id;
  String ? customer_name;
  String ? location;
  String ? order_status;
  double ? customer_latitude;
  double ? customer_longitude;
  String ? sellerid;

  Order({
    this.sellerid,
    this.products,
    this.userid,
    this.location,
    this.customer_name,
    this.customer_longitude,
    this.total_price,
    this.notes,
    this.order_status,
    this.date,
    this.order_id,
    this.customer_latitude,

  });
}
class OrderDatabase{


  Future Add_Order(Order myorder) async {


    Map<String, dynamic> data = {
      'products': myorder.products!.map(
              (e) => {
            'title': e.title,
            'subtitle': e.description,
            'price': e.price,
            'total_price':e.total,
            'quantity':e.quantity,
            'prodoct_id':e.product_doc_id

          }).toList(),
      'notes': myorder.notes,
      'total_price': myorder.total_price,
      'date': myorder.date,
      'userid':user_id,
      'location':myorder.location,
      'customer_latitude':myorder.customer_latitude,
      'customer_longitude':myorder.customer_longitude,
      'customer_name':myorder.customer_name,
      'order_status':'ongoing',
      'sellerid':myorder.sellerid.toString()
    };
    print("ek baars");

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    collection.add(data);

  }
}