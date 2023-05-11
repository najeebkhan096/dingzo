import 'dart:convert';
import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/nagotiate_time.dart';
import 'package:http/http.dart' as http;
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/selling/OrderProcessed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Checkout extends StatefulWidget {
  static const routename="Checkout";

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Constants _const=Constants();

  double totalamount=0;


bool calcaluted=false;

double productstotal=0.0;
bool loading=false;

MyUser ? seller;

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }




SchedulePickupTime ? pickuptime;
bool isloading=false;
  OrderDatabase _database=OrderDatabase();
  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment(Order new_order) async {
    try {

      paymentIntentData = await createPaymentIntent(
        amount:totalamount.toString(),
        currency: 'USD',
        appfee: 123,
        SellerAccountID: cartitems[0].seller!.stripe_account_id

      );

      //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');


      await stripe.Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              customerId: 'customer',
              applePay: stripe.PaymentSheetApplePay(
                merchantCountryCode: 'USA'
              ),
              googlePay: stripe.PaymentSheetGooglePay(
                merchantCountryCode: 'USA',
              ),

              style: ThemeMode.dark,

              merchantDisplayName: 'Najeeb khan'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet(new_order);
    } catch (e, s) {

      setState(() {
        isloading=false;
      });
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(Order new_order) async {

    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
          parameters: stripe.PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          ))
          .then((newValue) async {
        print('payment intent id is ' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        new_order.payment_id=paymentIntentData!['id'].toString();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(

          content: Text("paid successfully"),
          backgroundColor: Colors.green,
        ));


        await _database.Add_Order(new_order).then((returned_order_id) async {

          cartitems = [];
       
         await  database.updateProductStatus(
             productid: new_order.products![0].product_doc_id,
             status: 'in_progress',
             orderid: returned_order_id
          ).then((value) async{
           await socialMediaDatabase.sendPushMessage(title: 'You have new Order', body:"${currentuser!.username} has purchased your product",
               token: seller!.deviceid);

           Navigator.of(context).pushNamedAndRemoveUntil(HomeTesting.routename, (route) => false);

         });

        });

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        setState(() {
          isloading=false;
        });
        print('Exception/DISPLAYPAYMENTSHEET');
      });
    } on stripe.StripeException catch (e) {
      setState(() {
        isloading=false;
      });
      print('Exception/DISPLAYPAYMENTSHEET==> $e');

    } catch (e) {
      setState(() {
        isloading=false;
      });
      print(e.toString());
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent({String ? amount, String ? currency,int ? appfee,String ? SellerAccountID}) async {

      Map<String, dynamic> body = {
        'amount': calculateAmount(totalamount),
        'currency': currency,
        'capture_method': 'manual',
        'application_fee_amount':appfee.toString(),
        "transfer_data[destination]":SellerAccountID
      };

      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51IGzrSAWdh8XTc5i5j1vNDw4bbwYRZgAbdVwB4LEouLANRFcerYWv1tKDgOuW6RRm4vdr9N3LrUTlWvkpIQDKEa5005qLPLMOf',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);

  }

  calculateAmount(double amount) {
    final a = amount.toInt() * 100;
    return a.toString();
  }
  calculatetotal() {

    totalamount = 0;
    productstotal=0.0;
    cartitems.forEach((element) {

        totalamount = totalamount + (element.price!);
        productstotal = productstotal + (element.price!);
    });

    setState(() {
      calcaluted=true;
    });
  }

@override
  void initState() {
    // TODO: implement initState
    database.fetch_seller_mini_detail(DesiredUserID: cartitems[0].sellerid).then((value) {
      seller=value;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    if(calcaluted==false){
      calculatetotal();
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.8,
        leadingWidth: width*0.3
        ,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Checkout",style: _const.manrope_regular263238(20, FontWeight.w800)),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
        actions: [


        ],
      ),
      body:

      cartitems.length==0?
          Container(
              width: width*1,
              height: height*1,
              child: Center(child: Text("No Item")))
          :
      ListView(
        children: [

          SizedBox(  height: height*0.025,),
          Container(
            height: height*0.1,
            width: width*1,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(

                  children: [
                    if(cartitems.length>0)
                 CircleAvatar(
                   radius: 20,
                   backgroundImage: NetworkImage(cartitems[0].seller!.imageurl!),
                 ),
                    SizedBox(width: width*0.025,),
                    if(cartitems.length>0)
                    Text(cartitems[0].seller!.username!,style:_const.poppin_dark_brown(15, FontWeight.w600) ,)
                    ,
                  ],
                ),


              ],
            ),
          ),

          Divider(),


         Column(
           children: List.generate(cartitems.length, (index) =>
               Container(
             height: height*0.1,
             child: Row(
               children: [
                 Expanded(
                   flex: 1,
                   child: Container(

                     child: Center(child:
                     Text("${index+1}".toString(),
                         style: _const.poppin_dark_brown(20, FontWeight.w500))

                     ),
                   ),
                 ),
                 Expanded(
                   flex: 7,
                   child: Container(

                     child: Row(
                       children: [
                         (cartitems[index].photos![0]==null || cartitems[index].photos![0].isEmpty)?
                         Container(
                           width: width*0.25,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             color: Colors.indigo,
                           ),
                           child: Text("No Image"),
                         ):
                         Container(
                           width: width*0.25,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: Colors.indigo,
                               image: DecorationImage(
                                   fit: BoxFit.fill,
                                   image: NetworkImage(cartitems[index].photos![0].toString())
                               )
                           ),
                         ),
                         Container(
                           margin: EdgeInsets.only(left: width*0.025),
                           child: Column(

                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [

                               Text(cartitems[index].title.toString(),style: _const.poppin_dark_brown(12, FontWeight.w600)),
                               SizedBox(height: height*0.02,),
                               Text("Price : ${cartitems[index].price}",style: _const.poppin_dark_brown(12, FontWeight.w600)),


                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),

               ],
             ),

           ),),
         ),

          SizedBox(  height: height*0.025,),

          Divider(),

          Container(
              margin: EdgeInsets.only(left: width*0.05),
              child: Text("Order Summary",style: _const.poppin_Regualr(15, FontWeight.bold),)),

          SizedBox(  height: height*0.015,),

          Row(
            children: [
              Container(
                  width: width*0.25,
                  margin: EdgeInsets.only(left: width*0.05),
                  child: Text("Pickup ",style:TextStyle(
                      color: Colors.black54,
                      fontSize:12,
                      fontFamily: 'Poppins-SemiBold'
                  ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(cartitems.length>0)
                  Container(

                      child: Text(cartitems[0].seller!.home_address!.first.state.toString() ,style:TextStyle(
                          color: Colors.black,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                  Container(

                      child: Text(cartitems[0].seller!.home_address!.first.zipcode.toString()+" "+cartitems[0].seller!.home_address!.first.address1.toString()
                          +" "+cartitems[0].seller!.home_address!.first.city .toString()
                          ,style:TextStyle(
                          color: Colors.black54,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                ],
              )
            ],
          ),

          SizedBox(  height: height*0.015,),

          Divider(),
          SizedBox(  height: height*0.05,),
Container(
 margin: EdgeInsets.only(left: width*0.2,right: width*0.05),

  height: height*0.25,
  child: Column(
    children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  Text("Subtitle ",style:TextStyle(
      color: Colors.black54,
      fontSize:12,
      fontFamily: 'Poppins-SemiBold'
  )),

  Text("\$${productstotal.toString()}  ",style:TextStyle(
      color: Colors.black54,
      fontSize:12,
      fontFamily: 'Poppins-SemiBold'
  ))

],
),

      SizedBox(  height: height*0.01,),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Balance ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("Apply ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          ))

        ],
      ),
      SizedBox(  height: height*0.01,),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("You Pay ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("\$${totalamount} ",style:TextStyle(
              color: Colors.black54,
              fontSize:16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins-SemiBold'
          ))

        ],
      ),


    ],
  ),
),

          SizedBox(  height: height*0.025,),
          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.035),
              child: Text("Protect yourself against fruad scams which will result in loss of your money ",style:TextStyle(
                  color: Colors.black54,
                  fontSize:12,
                  fontFamily: 'Poppins-SemiBold'
              ),
              textAlign: TextAlign.center,
              )),
        Divider(),

          Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                    child: Text("Total (item)",style:TextStyle(
                        color: Colors.black,
                        fontSize:12,
                        fontFamily: 'Poppins-SemiBold'
                    ))),
                Container(

                    child: Text("\$${totalamount} ",style:TextStyle(
                        color: Colors.black,
                        fontSize:12,
                        fontFamily: 'Poppins-SemiBold'
                    ))),
              ],
            ),
          ),

          SizedBox(  height: height*0.025,),


          isloading?SpinKitRotatingCircle(
            color: Colors.black,
            size: 50.0,
          ):
              cartitems.length==0?Text(""):
          InkWell(
            onTap: ()async{

              if(pickuptime==null){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=> Nagatiate_Pickup_Time(current_order:      Order(
                  location: "",
                  drop_of_item_image:'',
                  userid: user_id,
                  customer_latitude: 0,
                  customer_longitude: 0,
                  customer_name: currentuser!.username,
                  date: DateTime.now(),
                  notes: '',
                  order_id: '',
                  order_status: 'in_progress',
                  products: cartitems,
                  sellerid: cartitems[0].sellerid,
                  total_price: totalamount,

                )))).then((value) async {
                  print("returned jaan "+value.toString());
                  if(value==null){

                  }
                  else{


                    setState((){
                      pickuptime=value;
                    });

                  }
                });
              }
              else{

                setState(() {
                  isloading=true;
                });

                await  makePayment(Order(
                  location: "",
                  drop_of_item_image: '',
                  userid: user_id,
                  customer_latitude: 0,
                  customer_longitude: 0,
                  customer_name: currentuser!.username,
                  date: DateTime.now(),
                  notes: '',
                  order_id: '',
                  order_status: 'in_progress',
                  products: cartitems,
                  sellerid: cartitems[0].sellerid,
                  total_price: totalamount,
                  picktime: pickuptime,
                ));
              }



            },
            child: Container(
              height: height*0.08,

              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                right: MediaQuery.of(context).size.width*0.05,),

              decoration: BoxDecoration(
                color: mycolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                    'Checkout',
                    style: _const.poppin_white(18, FontWeight.w600)
                ),
              ),
            ),
          ),
          SizedBox(  height: height*0.025,),

        ],
      ),
    );
  }
}
