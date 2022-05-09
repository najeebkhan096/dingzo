import 'dart:convert';
import 'package:dingzo/model/myuser.dart';
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

  List<Product> ? checkoutItems;
bool calcaluted=false;


bool loading=false;
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }


bool isloading=false;
  OrderDatabase _database=OrderDatabase();
  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment(Order new_order) async {
    try {
      paymentIntentData = await createPaymentIntent(
          totalamount.toString(), 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await stripe.Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
              paymentIntentClientSecret:
              paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'USA',
              merchantDisplayName: 'Najeeb khan'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet(new_order);
    } catch (e, s) {
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
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("paid successfully"),
          backgroundColor: Colors.green,
        ));

        paymentIntentData = null;
        _database.Add_Order(new_order)
            .then((value) {
          checkoutItems = [];
          cartitems=[];
          Navigator.of(context).pop();
        });


      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on stripe.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(totalamount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51K1GtiD5z0PA4b4f4tH4F98PGYq0ZsR95vIQzpKUffJ4NNbutHLSJaqrgZ7KiC5wrj2hDCMZc5sItlmXrwaTqNY700vFOcMCoX',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(double amount) {
    final a = amount.toInt() * 100;
    return a.toString();
  }
  calculatetotal() {
    totalamount = 0;
    checkoutItems!.forEach((element) {

        totalamount = totalamount + (element.price!);

    });
    setState(() {
      calcaluted=true;
    });
  }

@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    checkoutItems=ModalRoute.of(context)!.settings.arguments as List<Product>;

    if(calcaluted==false){
      calculatetotal();
    }
    return Scaffold(
      backgroundColor: Colors.white,

      body: ListView(
        children: [
          Container(
            height: height*0.18,
            width: width*1,
            decoration: BoxDecoration(
                color:  Color(0xffFFEA9D),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: width*0.05),
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                  ),
                ),
                SizedBox(width: width*0.2,),
                Text("Checkout",style:_const.raleway_extrabold(30, FontWeight.w800) ,)
              ],
            ),
          ),

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
                    Container(
                      margin: EdgeInsets.only(left: width*0.025),
                      child: Image.asset('images/Ellipse 13.png',height: height*0.1,),
                    ),
                    SizedBox(width: width*0.025,),
                    Text("radiant.aestethic",style:_const.poppin_dark_brown(15, FontWeight.w600) ,)
                    ,
                  ],
                ),


                Checkbox(value: false, onChanged: (val){},
                  activeColor: Color(0xff8B6824),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                  ),
                )
              ],
            ),
          ),

          Divider(),


         Column(
           children: List.generate(checkoutItems!.length, (index) =>
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
                         (checkoutItems![index].photos![0]==null || checkoutItems![index].photos![0].isEmpty)?
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
                                   image: NetworkImage(checkoutItems![index].photos![0].toString())
                               )
                           ),
                         ),
                         Container(
                           margin: EdgeInsets.only(left: width*0.025),
                           child: Column(

                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [

                               Text(checkoutItems![index].title.toString(),style: _const.poppin_dark_brown(12, FontWeight.w600)),
                               SizedBox(height: height*0.02,),
                               Text("Price : ${checkoutItems![index].price}",style: _const.poppin_dark_brown(12, FontWeight.w600)),


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
         Container(
             margin: EdgeInsets.only(left: width*0.05),
             child: Text("Delivery : UPS First Class: \$4.00",style: _const.poppin_Regualr(15, FontWeight.w600),)),
          SizedBox(  height: height*0.015,),

          Container(
              margin: EdgeInsets.only(left: width*0.05),
              child: Text("Delivery : ETA 20 March - 30 march",style:TextStyle(
                  color: Colors.black54,
                  fontSize:12,
                  fontFamily: 'Poppins-SemiBold'
              ))),


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
                  child: Text("Delivery to ",style:TextStyle(
                      color: Colors.black54,
                      fontSize:12,
                      fontFamily: 'Poppins-SemiBold'
                  ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                      child: Text("AZ ",style:TextStyle(
                          color: Colors.black,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                  Container(

                      child: Text("1480 Big Run road seaman ohio ",style:TextStyle(
                          color: Colors.black54,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                ],
              )
            ],
          ),

          SizedBox(  height: height*0.015,),


          Row(
            children: [
              Container(
                width: width*0.25,
                  margin: EdgeInsets.only(left: width*0.05),
                  child: Text("Card & Billing ",style:TextStyle(
                      color: Colors.black54,
                      fontSize:12,
                      fontFamily: 'Poppins-SemiBold'
                  ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                      child: Text("AZ ",style:TextStyle(
                          color: Colors.black,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                  Container(
                      child: Text("1480 Big Run road seaman ohio ",style:TextStyle(
                          color: Colors.black54,
                          fontSize:12,
                          fontFamily: 'Poppins-SemiBold'
                      ))),
                ],
              )
            ],
          ),

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

  Text("\$5.0  ",style:TextStyle(
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
          Text("Shipping ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("\$6.0  ",style:TextStyle(
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
          Text("Tax ",style:TextStyle(
              color: Colors.black54,
              fontSize:12,
              fontFamily: 'Poppins-SemiBold'
          )),

          Text("\$2.0  ",style:TextStyle(
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
              child: Text("Protect yourself against fruad scams which will resukt in loss of your money ",style:TextStyle(
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
          InkWell(
            onTap: (){
            setState(() {
              isloading=true;
            });
              makePayment(Order(
                location: "",
                userid: user_id,
                customer_latitude: 0,
                customer_longitude: 0,
                customer_name: currentuser!.username,
                date: '',
                notes: '',
                order_id: '',
                order_status: 'Ongoing',
                products: checkoutItems,
                sellerid: checkoutItems![0].sellerid,
                total_price: totalamount
              ));
              // Navigator.of(context).pushNamed(OrderProcessed.routename);

            },
            child: Container(
              height: height*0.08,

              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                right: MediaQuery.of(context).size.width*0.05,),

              decoration: BoxDecoration(
                color: Color(0xffEFB546),
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
