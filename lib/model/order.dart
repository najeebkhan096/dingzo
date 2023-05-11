import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  List<Product> ? products;
  double ? total_price;
  String ? notes;
  DateTime ? date;
  String ? userid;
  String ? order_id;
  String ? customer_name;
  String ? location;
  String ? order_status;
  double ? customer_latitude;
  double ? customer_longitude;
  String ? sellerid;
  SchedulePickupTime ? picktime;
  String ? drop_of_item_image;
  bool ?seller_rate;
bool ? buyer_rate;
String ? payment_id;
DateTime ? rating_due_date;
  Order({
    this.rating_due_date,
    this.payment_id,
    this.seller_rate,
    this.buyer_rate,
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
    this.picktime,
    required
    this.drop_of_item_image

  });
}

class SchedulePickupTime{
  final DateTime ? date;
  final String ? time;
  final String ? comment;
  SchedulePickupTime({required this.date,required this.time,this.comment});
}

class OrderDatabase{


  Future<String> Add_Order(Order myorder) async {

String ? orderid;
    Map<String, dynamic> data = {
      'payment_id':myorder.payment_id,
      'products': myorder.products!.map(
              (e) => {
            'title': e.title,
            'subtitle': e.description,
            'price': e.price,
            'total_price':e.total,
            'quantity':e.quantity,
                'category':e.category,
            'prodoct_id':e.product_doc_id,
                'imageurl':e.photos,
                'rent':e.rent,
                'rent_fare':e.rent_fare,
                'rent_duration':e.rent_duration,
                'sellerid':e.sellerid,
                'sellername':e.sellername


          }).toList(),
      'notes': myorder.notes,
      'total_price': myorder.total_price,
      'date': myorder.date,
      'userid':user_id,
      'location':myorder.location,
      'customer_latitude':myorder.customer_latitude,
      'customer_longitude':myorder.customer_longitude,
      'customer_name':myorder.customer_name,
      'order_status':'in_progress',
      'drop_of_item_image':'',
      'sellerid':myorder.sellerid.toString(),
      'seller_rate':false,
      'buyer_rate':false,
      'pickup':{
        'date':myorder.picktime!.date,
        'time':myorder.picktime!.time,
            'comment':myorder.picktime!.comment
      }
    };


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
   final result=await  collection.add(data);
orderid=result.id;
  return orderid;
  }

  Future<Order?> fetch_in_progress_orders_by_product(Product desired_product) async {
  Order ? myorder ;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;



        if (fetcheddata['order_status'] != null) {

              List<dynamic> myproducts = fetcheddata['products'];
              myproducts.forEach((prod) {
                if(prod['prodoct_id']==desired_product.product_doc_id){
                  Timestamp stamp = fetcheddata['date'];
                  DateTime date = stamp.toDate();


                  Timestamp pickupstamp = fetcheddata['pickup']['date'];
                  DateTime pickupdate = pickupstamp.toDate();


                  Timestamp ?rating_due_date_stamp;
                  try{
                    rating_due_date_stamp=fetcheddata['rating_due_date'];
                  } catch(error){

                  }

                  myorder=Order(
                    picktime: SchedulePickupTime(date: pickupdate, time: fetcheddata['pickup']['time'],comment: fetcheddata['pickup']['comment'].toString()),

                    payment_id:fetcheddata['payment_id'] ,
                    drop_of_item_image: fetcheddata['drop_of_item_image'],
                    order_id: element.id,
                    seller_rate: fetcheddata['seller_rate'],
                    buyer_rate: fetcheddata['buyer_rate'],
                    location: fetcheddata['location'].toString(),
                    customer_name: fetcheddata['customer_name'].toString(),
                    notes: fetcheddata['notes'].toString(),
                    total_price: double.parse(fetcheddata['total_price'].toString()),
                    userid: fetcheddata['userid'],
                    order_status: fetcheddata['order_status'].toString(),
                    customer_latitude: fetcheddata['customer_latitude'],
                    customer_longitude: fetcheddata['customer_longitude'],
                    date: date,
                    products: [desired_product],
                    rating_due_date:
                    fetcheddata['order_status']=="rating"?
                    rating_due_date_stamp!.toDate():
                        DateTime.now()
                  );
                }
              });


        }
      });
    });

    return myorder;
  }

  Future<List<Order>> fetch_in_progress_orders({required String ? desired_id}) async {
    List<Order> myorders = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];


        if (fetcheddata['order_status'] != null) {

          if (
          fetcheddata['order_status'] == "in_progress"
          ||   fetcheddata['order_status'] == "rating"
          ||   fetcheddata['order_status'] == "in_use"
          || fetcheddata['order_status'] == "pickup"

          ) {

            if (desired_id == fetcheddata['userid']) {
              Timestamp stamp = fetcheddata['date'];

              Timestamp pickupstamp = fetcheddata['pickup']['date'];
              DateTime date = stamp.toDate();
              DateTime pickupdate = pickupstamp.toDate();
              myorders.add(
                  Order(
                    drop_of_item_image: fetcheddata['drop_of_item_image'],
                order_id: element.id,
                picktime: SchedulePickupTime(date: pickupdate, time: fetcheddata['pickup']['time'],comment: fetcheddata['pickup']['comment'].toString()),
                sellerid: fetcheddata['sellerid'],
                location: fetcheddata['location'].toString(),
                customer_name: fetcheddata['customer_name'].toString(),
                notes: fetcheddata['notes'].toString(),
                total_price: double.parse(fetcheddata['total_price'].toString()),
                userid: fetcheddata['userid'],
                order_status: fetcheddata['order_status'].toString(),
                customer_latitude: fetcheddata['customer_latitude'],
                customer_longitude: fetcheddata['customer_longitude'],
                date:
                date,
                products: myproducts
                    .map(
                      (e)
                    {
                      List<dynamic> my=e['imageurl'];
                      List<String> photos=[];
                      my.forEach((element) {
                        photos.add(element.toString());
                      });
                    return Product(
                      price: double.parse(e['price'].toString()),
                      quantity: e['quantity'],
                      title: e['title'].toString(),
                       rent_fare: double.parse(e['rent_fare'].toString()),
                       rent_duration: e['rent_duration'],
                      product_doc_id: e['prodoct_id'],
                      sellername: e['sellername'],
                      rent: e['rent'],
                       id: element.id,
                        indiviusal_totalprice: fetcheddata['total_price'],
                        photos: photos
                      );}
                )
                    .toList(),
              ));
            }
          }
        }
      });
    });
print("progress orders length is "+myorders.length.toString());
    return myorders;
  }
  Future<List<Order>> fetch_completed_Orders({required String ? desired_id}) async {
    List<Order> myorders = [];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        List<dynamic> myproducts = fetcheddata['products'];


        if (fetcheddata['order_status'] != null) {

          if (
          fetcheddata['order_status'] == "completed") {

            if (desired_id == fetcheddata['userid']) {
              print("Hello World");
              Timestamp stamp = fetcheddata['date'];
              Timestamp pickupstamp = fetcheddata['pickup']['date'];
              DateTime date = stamp.toDate();
              DateTime pickupdate = pickupstamp.toDate();
              myorders.add(Order(
                drop_of_item_image: fetcheddata['drop_of_item_image'],
                order_id: element.id,
                picktime: SchedulePickupTime(date: pickupdate, time: fetcheddata['pickup']['time'],comment: fetcheddata['pickup']['comment'].toString()),

                location: fetcheddata['location'].toString(),
                customer_name: fetcheddata['customer_name'].toString(),
                notes: fetcheddata['notes'].toString(),
                total_price: double.parse(fetcheddata['total_price'].toString()),
                userid: fetcheddata['userid'],
                order_status: fetcheddata['order_status'].toString(),
                customer_latitude: fetcheddata['customer_latitude'],
                customer_longitude: fetcheddata['customer_longitude'],
                date:
                date,
                products: myproducts
                    .map(
                        (e)
                    {
                      List<dynamic> my=e['imageurl'];
                      List<String> photos=[];
                      my.forEach((element) {
                        photos.add(element.toString());
                      });
                      return Product(
                          price: double.parse(e['price'].toString()),
                          quantity: e['quantity'],
                          title: e['title'].toString(),
                          id: element.id,
                          indiviusal_totalprice: fetcheddata['total_price'],
                          photos: photos
                      );}
                )
                    .toList(),
              ));
            }
          }
        }
      });
    });
    print("progress orders length is "+myorders.length.toString());
    return myorders;
  }

  Future<void> update_pickup_time({String ? orderdocid,SchedulePickupTime ? pickuptime}) async {


    Map<String, dynamic> data = {
      'pickup':{
        'date':pickuptime!.date,
        'time':pickuptime.time,
        'comment':pickuptime.comment.toString()
      }

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    final result=await collection.doc(orderdocid).update(data);

  }


}
OrderDatabase orderdatabase=OrderDatabase();


