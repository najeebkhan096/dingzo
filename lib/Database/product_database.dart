import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/database.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ProductDatabase{
  Future<List<Product>> fetch_requested_products() async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {


      Future.forEach(snapshot.docs, (snaps) {

        QueryDocumentSnapshot doc=snaps as QueryDocumentSnapshot;
        Map<String, dynamic> fetcheddata= doc.data() as Map<String, dynamic>;


        if(fetcheddata['seller_id']!=currentuser!.uid && fetcheddata['product_status']=='requested'){
          List<dynamic> photos = fetcheddata['photos'];
          List<dynamic> likesdynamic=fetcheddata['likes'];
          List<Likes> _likes_list=[];
          //
          likesdynamic.forEach((element) {

            _likes_list.add(
                Likes(
                    userid: element['userid'].toString(),
                    status: element['status']
                )
            );
          });

          bool ? status=false;
          int targetindex=_likes_list.indexWhere((element) => element.userid==currentuser!.uid);

          if(targetindex==-1){
            status=false;
          }

          else{
            status= _likes_list[targetindex].status;
          }

          Product new_product = Product(
              likes: _likes_list,
              like_status: status,
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              views: fetcheddata['views'],
              rent_duration: fetcheddata['rent_duration'],
              rent_fare: fetcheddata['rent_fare'],
              id: doc.id,
              product_status: fetcheddata['product_status'],
              rent: fetcheddata['rent'],
              date: DateTime.parse(fetcheddata['date']),
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id:doc.id,
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

    });


    return newCategories;
  }

  Future<List<Product>> fetch_all_requested_products() async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {


      Future.forEach(snapshot.docs, (snaps) {

        QueryDocumentSnapshot doc=snaps as QueryDocumentSnapshot;
        Map<String, dynamic> fetcheddata= doc.data() as Map<String, dynamic>;


        if(fetcheddata['product_status']=='requested'){
          List<dynamic> photos = fetcheddata['photos'];
          List<dynamic> likesdynamic=fetcheddata['likes'];
          List<Likes> _likes_list=[];
          //
          likesdynamic.forEach((element) {

            _likes_list.add(
                Likes(
                    userid: element['userid'].toString(),
                    status: element['status']
                )
            );
          });

          bool ? status=false;
          int targetindex=_likes_list.indexWhere((element) => element.userid==currentuser!.uid);

          if(targetindex==-1){
            status=false;
          }

          else{
            status= _likes_list[targetindex].status;
          }

          Product new_product = Product(
              likes: _likes_list,
              like_status: status,
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              views: fetcheddata['views'],
              rent_duration: fetcheddata['rent_duration'],
              rent_fare: fetcheddata['rent_fare'],
              id: doc.id,
              product_status: fetcheddata['product_status'],
              rent: fetcheddata['rent'],
              date: DateTime.parse(fetcheddata['date']),
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id:doc.id,
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

    });


    return newCategories;
  }

  Future<List<Product>> fetch_browse_services() async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {


      Future.forEach(snapshot.docs, (snaps) {

        QueryDocumentSnapshot doc=snaps as QueryDocumentSnapshot;
        Map<String, dynamic> fetcheddata= doc.data() as Map<String, dynamic>;


        if(fetcheddata['seller_id']!=currentuser!.uid && fetcheddata['product_status']=="listed"){
          List<dynamic> photos = fetcheddata['photos'];
          List<dynamic> likesdynamic=fetcheddata['likes'];
          List<Likes> _likes_list=[];
          //
          likesdynamic.forEach((element) {

            _likes_list.add(
                Likes(
                    userid: element['userid'].toString(),
                    status: element['status']
                )
            );
          });

          bool ? status=false;
          int targetindex=_likes_list.indexWhere((element) => element.userid==currentuser!.uid);

          if(targetindex==-1){
            status=false;
          }

          else{
            status= _likes_list[targetindex].status;
          }

          Product new_product = Product(
              likes: _likes_list,
              like_status: status,
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              views: fetcheddata['views'],
              rent_duration: fetcheddata['rent_duration'],
              rent_fare: fetcheddata['rent_fare'],
              id: doc.id,
              product_status: fetcheddata['product_status'],
              rent: fetcheddata['rent'],
              date: DateTime.parse(fetcheddata['date']),
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id:doc.id,
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

    });


    return newCategories;
  }
  Future<List<Product>> fetch_browse_services_bititle({String ? title}) async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {


      Future.forEach(snapshot.docs, (snaps) {

        QueryDocumentSnapshot doc=snaps as QueryDocumentSnapshot;
        Map<String, dynamic> fetcheddata= doc.data() as Map<String, dynamic>;


        if(fetcheddata['seller_id']!=currentuser!.uid && fetcheddata['category']==title){
          List<dynamic> photos = fetcheddata['photos'];
          List<dynamic> likesdynamic=fetcheddata['likes'];
          List<Likes> _likes_list=[];
          //
          likesdynamic.forEach((element) {

            _likes_list.add(
                Likes(
                    userid: element['userid'].toString(),
                    status: element['status']
                )
            );
          });

          bool ? status=false;
          int targetindex=_likes_list.indexWhere((element) => element.userid==currentuser!.uid);

          if(targetindex==-1){
            status=false;
          }

          else{
            status= _likes_list[targetindex].status;
          }

          Product new_product = Product(
              likes: _likes_list,
              like_status: status,
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              views: fetcheddata['views'],
              rent_duration: fetcheddata['rent_duration'],
              rent_fare: fetcheddata['rent_fare'],
              id: doc.id,
              product_status: fetcheddata['product_status'],
              rent: fetcheddata['rent'],
              date: DateTime.parse(fetcheddata['date']),
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id:doc.id,
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

    });


    return newCategories;
  }

  Future<List<Product>> fetch_most_viewed() async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> photos = fetcheddata['photos'];
        List<dynamic> likesdynamic=fetcheddata['likes'];
        List<Likes> _likes_list=[];
        //
        likesdynamic.forEach((element) {

          _likes_list.add(
              Likes(
                  userid: element['userid'].toString(),
                  status: element['status']
              )
          );
        });

        bool ? status=false;
        int targetindex=_likes_list.indexWhere((element) => element.userid==currentuser!.uid);

        if(targetindex==-1){
          status=false;
        }

        else{
          status= _likes_list[targetindex].status;
        }

        Product new_product = Product(
            likes: _likes_list,
            like_status: status,
            title: fetcheddata['title'],
            price: fetcheddata['price'],
            quantity: 1,
            views: fetcheddata['views'],
            rent_duration: fetcheddata['rent_duration'],
            rent_fare: fetcheddata['rent_fare'],
            id: element.id,
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
      });
    }).then((value) {

    });


    return newCategories;
  }

  Future<List<Product>> fetch_my_likes() async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> photos = fetcheddata['photos'];
        List<dynamic> likesdynamic=fetcheddata['likes'];
        List<Likes> _likes_list=[];
        //
        likesdynamic.forEach((element) {

          _likes_list.add(
              Likes(
                  userid: element['userid'].toString(),
                  status: element['status']
              )
          );
        });

        bool ? status=false;
        int targetindex=_likes_list.indexWhere((element) => element.userid==currentuser!.uid);

        if(targetindex==-1){
          status=false;
        }

        else{
          status= _likes_list[targetindex].status;
        }

        Product new_product = Product(
            likes: _likes_list,
            like_status: status,
            title: fetcheddata['title'],
            price: fetcheddata['price'],
            quantity: 1,
            views: fetcheddata['views'],
            rent_duration: fetcheddata['rent_duration'],
            rent_fare: fetcheddata['rent_fare'],
            id: element.id,
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
      });
    }).then((value) {

    });


    return newCategories;
  }

  Future<List<Product>> fetch_all_products_by_userid({String ? desiredid}) async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) async {

      await Future.forEach( snapshot.docs, (myelement) async {
        final QueryDocumentSnapshot<Object> doc_snapshot=myelement as QueryDocumentSnapshot<Object>;

        Map  fetcheddata= doc_snapshot.data() as Map<String, dynamic>;
        MyUser ? desireduser =await _database.fetchprofiledata(DesiredUserID: fetcheddata['seller_id']);
        if(fetcheddata['seller_id']==desiredid){
          List<dynamic> photos = fetcheddata['photos'];


          Product new_product = Product(
            title: fetcheddata['title'],
            price: fetcheddata['price'],
            quantity: 1,
            views: fetcheddata['views'],
            id: doc_snapshot.id,
            status: fetcheddata['status'],
            category: fetcheddata['category'],
            product_doc_id: doc_snapshot.id,
            description: fetcheddata['description'],
            rent_duration: fetcheddata['rent_duration'],
            rent: fetcheddata['rent'],
            rent_fare: double.parse(fetcheddata['rent_fare'].toString()),
            total: 0,

            selected: false,
            photos:photos
                .map(
                    (e) => e['imageurl'].toString()
            )
                .toList(),

            sellerid: fetcheddata['seller_id'],

            sales: fetcheddata['sales'],
            sellername: fetcheddata['seller_name'].toString(),
            product_status: fetcheddata['product_status'],
            date: DateTime.parse(fetcheddata['date']),
            seller: desireduser,
          );
          newCategories.add(new_product);



        }

      });


    }).then((value) async {
      newCategories.sort((a,b)=>a.sales!.toInt() .compareTo(b.sales!.toInt() ));
      newCategories=newCategories.reversed.toList();
      await Future.forEach(newCategories, (element) {
        Product newprod=element as Product;
        print("Sajan"+newprod.title.toString());
      });


    });

    return newCategories;
  }
  Future<List<Product>> fetch_all_for_sale_products_by_Title({String ? title}) async {

    Database _database=Database();

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) async {

      await Future.forEach( snapshot.docs, (myelement) async {
        final QueryDocumentSnapshot<Object> doc_snapshot=myelement as QueryDocumentSnapshot<Object>;

        Map  fetcheddata= doc_snapshot.data() as Map<String, dynamic>;
        MyUser ? desireduser =await _database.fetchprofiledata(DesiredUserID: fetcheddata['seller_id']);

        if(fetcheddata['product_status']=='listed' && fetcheddata['seller_id']!=currentuser!.uid) {

          List<dynamic> photos = fetcheddata['photos'];

          if (fetcheddata['category'] == title) {

            Product new_product = Product(
                title: fetcheddata['title'],
                price: fetcheddata['price'],
                quantity: 1,
                views: fetcheddata['views'],
                id: doc_snapshot.id,
                status: fetcheddata['status'],
                category: fetcheddata['category'],
                product_doc_id: doc_snapshot.id,
                description: fetcheddata['description'],
                rent_duration: fetcheddata['rent_duration'],
                rent: fetcheddata['rent'],
                rent_fare: double.parse(fetcheddata['rent_fare'].toString()),
                total: 0,

                selected: false,
                photos:photos
                    .map(
                        (e) => e['imageurl'].toString()
                )
                    .toList(),

                sellerid: fetcheddata['seller_id'],

                sales: fetcheddata['sales'],
                sellername: fetcheddata['seller_name'].toString(),
                product_status: fetcheddata['product_status'],
                date: DateTime.parse(fetcheddata['date']),
                seller: desireduser
            );
            newCategories.add(new_product);

          }

        }

      });


    }).then((value) async {
      newCategories.sort((a,b)=>a.sales!.toInt() .compareTo(b.sales!.toInt() ));
      newCategories=newCategories.reversed.toList();
      await Future.forEach(newCategories, (element) {
        Product newprod=element as Product;
        print("Sajan"+newprod.title.toString());
      });


    });

    return newCategories;
  }

  Future<List<Product>> fetch_sold_products_by_userid({required desireduserid}) async {

    List<Product> newCategories = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        if(desireduserid==fetcheddata['seller_id'] &&  fetcheddata['product_status']=='sold' ){
          List<dynamic> photos = fetcheddata['photos'];

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

  Future<List<Product>> fetch_ForSale_products_by_userid({required desireduserid}) async {

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {

      snapshot.docs.forEach((element) {

        Map fetcheddata = element.data() as Map<String, dynamic>;

        if( desireduserid == fetcheddata['seller_id'] &&  fetcheddata['rent']==false ){

          List<dynamic> photos = fetcheddata['photos'];

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
            selected: false,
            photos:photos
                .map(
                    (e) => e['imageurl'].toString()
            )
                .toList(),
            sellerid: fetcheddata['seller_id'],
            sales: fetcheddata['sales'],
            sellername: fetcheddata['seller_name'].toString(),
            views: fetcheddata['views'],
            rent: fetcheddata['rent'],
            rent_duration: fetcheddata['rent_duration'],
            rent_fare: fetcheddata['rent_fare'],

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
  Future<List<Product>> fetch_ForRent_products_by_userid({required desireduserid}) async {

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {

      snapshot.docs.forEach((element) {

        Map fetcheddata = element.data() as Map<String, dynamic>;

        if( desireduserid == fetcheddata['seller_id'] &&  fetcheddata['rent']==true ){

          List<dynamic> photos = fetcheddata['photos'];

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
              selected: false,
              photos:photos
                  .map(
                      (e) => e['imageurl'].toString()
              )
                  .toList(),
              sellerid: fetcheddata['seller_id'],
              sales: fetcheddata['sales'],
              sellername: fetcheddata['seller_name'].toString(),
              views: fetcheddata['views'],
              rent: fetcheddata['rent']

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
  Future<String> uploadProduct({Product ? product})async{
    String docid='';
    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    var response =await imgRef.add({
      'both_service':product!.both_service,
      'likes':[],
      'title':product.title,
      'rent_duration':product.rent_duration,
      'rent_fare':product.rent_fare,
      'description': product.description,
      'price':product.price,
      'photos': product.photos!.map(
              (e) => {
            'imageurl': e,
          }).toList(),

      'category':product.category,
      'status':true,

      'seller_id':product.sellerid,
      'seller_name':product.sellername,
      'sales':product.sales,
      'product_status':product.product_status,
      'views':0,
      'rent':product.rent,
      'date':DateTime.now().toString()

    });
    return response.id;
  }
  Future update_product({Product ? product})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    await imgRef.doc(product!.id). update({

      'title':product.title,
      'description': product.description,
      'price':product.price,
      'rent_duration':product.rent_duration,
      'rent_fare':product.rent_fare,
      'photos': product.photos!.map(
              (e) => {
            'imageurl': e,
          }).toList(),

      'category':product.category,
      'status':true,
      'seller_id':product.sellerid,
      'seller_name':product.sellername,
      'sales':product.sales,
      'product_status':product.product_status,
      'rent':product.rent,
      'views':product.views,
      'date':DateTime.now().toString()

    });
  }

  Future delete_product({String ? proddocid})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    await imgRef.doc(proddocid).delete();
  }

  Future update_views({String ? productid,int? views})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    await imgRef.doc(productid). update({
      'views':views,

    });
  }
  Future update_status({String ? productid,String? status})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    await imgRef.doc(productid). update({
      'product_status':status,

    });
  }
  Future<double> getTheDistance(
      {LatLng? initial, LatLng? final_position}) async {
    double cal_distance = 0;

    double distanceImMeter = await Geolocator.distanceBetween(
      initial!.latitude,
      initial.longitude,
      final_position!.latitude,
      final_position.longitude,
    );

    print("distance in meter is " + distanceImMeter.toString());
    cal_distance=distanceImMeter;


    return cal_distance;
  }
}

ProductDatabase productdatabase=ProductDatabase();