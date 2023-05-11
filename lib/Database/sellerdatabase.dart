import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:path/path.dart' as Path;


class SellerDatabase{


  Future<List<Product>> fetch_completed_SellerProducts({String ? userid}) async {
    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        List<dynamic> photos = fetcheddata['photos'];

        if (fetcheddata['seller_id'] == userid && fetcheddata['product_status']=='completed') {

          Product new_product = Product(
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              id: element.id,
              rent_duration: fetcheddata['rent_duration'],
              rent_fare: fetcheddata['rent_fare'],
              product_status: fetcheddata['product_status'],
              rent: fetcheddata['rent'],
              date: DateTime.parse(fetcheddata['date']),
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id: element.id,
              description: fetcheddata['description'],
              total: 0,

              selected: false,
              photos:photos
                  .map(
                      (e) => e['imageurl'].toString()
              )
                  .toList(),

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
  Future<List<Product>> fetch_Seller_InProgress_Orders() async {
    List<Product> fetchedproducts = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];


        if (fetcheddata['order_status'] != null) {

          if (
          fetcheddata['order_status'] == "in_progress") {

              Timestamp stamp = fetcheddata['date'];
              DateTime date = stamp.toDate();
                myproducts.forEach((product) {

  if(product['sellerid']==user_id){

    List<dynamic> my=product['imageurl'];

    List<String> photos=[];
    my.forEach((myimage) {

      photos.add(myimage.toString());
    });

    fetchedproducts.add(
    Product(
        price: product['price'],
        quantity: product['quantity'],
        title: product['title'].toString(),
        id: element.id,
        indiviusal_totalprice: fetcheddata['total_price'],
        photos: photos,
      sellerid: element['sellerid'],

    ));
  }
});


          }
        }
      });
    });


    return fetchedproducts;

  }


}
SellerDatabase sellerdatabase=SellerDatabase();





List<Product> buyer_complete_Orders=[];
