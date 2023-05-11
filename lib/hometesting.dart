import 'dart:math';

import 'package:dingzo/Address/location.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/location/google_places_api.dart';
import 'package:dingzo/screens/setting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/notificationservice/local_notification_service.dart';
import 'package:dingzo/screens/mylikes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dingzo/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/home/search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/Database/payment.dart';
import 'package:dingzo/Database/sellerdatabase.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/categories.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:dingzo/screens/chat/conversation.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/screens/notification.dart';
import 'package:dingzo/screens/selling/selling_bottom_bar.dart';
import 'package:dingzo/screens/viewprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


var tstyle = TextStyle(color: Colors.white.withOpacity(0.6),
    fontSize: 50
);

PageController bottom_controller = PageController();
int bottom_index = 0;
class HomeTesting extends StatefulWidget {
  static const routename="HomeTesting";
  @override
  _HomeTestingState createState() => _HomeTestingState();
}

class _HomeTestingState extends State<HomeTesting> {
  var padding = EdgeInsets.symmetric(horizontal: 18,vertical: 5);
  double gap =10;


  Future<bool?>  _show_exit_dialgue() async{
    bool ?status;
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff242C29),
          content:
          Text("Are you sure you want to Exit?",
            style: _const.poppin_white(16, FontWeight.w600),
          ),

          actions: <Widget>[

            Container(
              decoration: BoxDecoration(
                  color: Color(0xff9A0303),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('Yes',style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  Navigator.pop(context,true);
                },
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff20C997),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                child: Text('No',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.pop(context,false);
                },
              ),

            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          ],
        )
    ).then((value) {
      print("lund"+value.toString());
      status=value;

    });
    return status;
  }

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? mtoken = "clDp0-WnStCc5nruahpEUI:APA91bFUuZ2LHNNcJE6TQyfdrNl9cKWryeHkNh95zQpLMQCGgwRYpza9JoGCf1BwubHOvF3SKvcLqa__Me4j4wuGS50AXeyKMC-sMcXmdxvTgOQdAv4pWM-fw8Tqpx2hpkRiy0vP8ePl";






  Database _database=Database();

  SellerDatabase sellerDatabase=SellerDatabase();
  String  deviceTokenToSendPushNotification='';
  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    _database.update_device_id(deviceid: deviceTokenToSendPushNotification);

  }


  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        LocalNotificationService.createanddisplaynotification(message);
        // flutterLocalNotificationsPlugin.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //       // TODO add a proper drawable resource to android, for now using
        //       //      one that already exists in example app.
        //       icon: 'launch_background',
        //     ),
        //   ),
        // );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }




  void _showSuspendDialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Alert"),
          content: Text("Your Account is suspended"),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () async{
                FirebaseAuth _auth=  FirebaseAuth.instance;
                await _auth.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Wrapper()),
                          (route)=>false
                  );
                });
              },
            )
          ],
        ));
  }
  @override
  void dispose() {
     // TODO: implement dispose
    _bannerAd!.dispose();
    super.dispose();
  }
bool fetched=false;
   BannerAd ?_bannerAd;
  bool ad_loaded=false;
  _initBannerAd()async{
    _bannerAd= BannerAd(
      adUnitId: 'ca-app-pub-9207548761153845/1202976546',
      size: AdSize.banner,
      request: AdRequest(),

      listener: BannerAdListener(
          onAdLoaded: (ad){
print("laoded");
            Random random = new Random();
            int randomNumber = random.nextInt(all_products.length);
            browse_products.insert(randomNumber,
                Product(id: '', price: 11, title: '', quantity: 1,banner: true)

            );
            setState(() {
              fetched=true;
              ad_loaded=true;
            });

          },
          onAdFailedToLoad: (ad,error){
            print("not laoded");
            setState(() {
              browse_products=all_products;
              ad_loaded=true;
              fetched=true;
            });
          }
      ),
    );
    await  _bannerAd!.load().then((value) {
      setState(() {
        fetched=true;
        ad_loaded=true;
      });
    });

  }



  List<Product> all_products=[];
  List<Product> browse_products=[];
  Future fetch_all_products()async{
    all_products=[];
    browse_products=[];


    await productdatabase.fetch_browse_services().then((value) {
      all_products=value;


      Future.forEach(all_products, (_prod) async{
        Product new_product=_prod as Product;
        await  _database.fetch_mini_user(DesiredUserID: new_product.sellerid).then((seller) async{


          double distance= await productdatabase.getTheDistance(final_position:

          LatLng(currentuser!.location_details!.latitude!,
              currentuser!.location_details!.longitude!

          ),
              initial: LatLng(seller!.location_details!.latitude!, seller.location_details!.longitude!)
          );
          double miles=distance*0.000621371;

          _prod.distance=miles;

          if(miles<currentuser!.filter_distance!){
            browse_products.add(_prod);
            List<Product> new_likes=[];
            value.forEach((element) {

              if(element.like_status==true){

                new_likes.add(element);

              }

            }
            );


          }
        });


      }).then((value) {

      });







    });
  }
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
if(fetched==false){
  await database.fetchprofiledata(DesiredUserID: user_id).then((value) async {
    currentuser = value;

    user_docid=currentuser!.doc!;
    if(currentuser!.suspend!){
      _showSuspendDialog();
    }
    else if(currentuser!.home_address!.length==0){

      Navigator.of(context).pushReplacementNamed(EditAddress.routename).then((value) {

      });


    }
    else{

      await getDeviceTokenToSendNotification();
print("my device id is "+currentuser!.deviceid.toString());
      await    fetch_all_products().then((value) {
        _initBannerAd();


      });
    }





  }
  );
}



    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    bottom_index=0;
    requestPermission();
    loadFCM();
    listenFCM();
    FirebaseMessaging.instance.subscribeToTopic("Animal");

    super.initState();
  }

  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool  status=false;
       await _show_exit_dialgue().then((value) {
         if(value!=null){
           status=value;
         }
       });
      return status;
       },
      child: Scaffold(
       backgroundColor: Colors.white,
        appBar:

fetched==false?  AppBar(
  elevation: 0,
  leadingWidth: width*0.3
  ,
  backgroundColor: Colors.white,
  centerTitle: true,
  title: Text("",style: _const.manrope_regular263238(20, FontWeight.w800)),

):
        bottom_index==0?AppBar(
          elevation: 0,
          toolbarHeight: height*0.15, // Set this height
          flexibleSpace: Container(
            color: Colors.white,
            child: ListView(
              children: [
                SizedBox(height: height*0.075,),
                InkWell(
                  onTap: (){
                  },
                  child: Center(
                    child: Container(

                      width: width*0.9,
                      height: height*0.06,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff2B2B2B)
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        onTap: (){


                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SearchProducts_Screen();
                          })).then((value) {

                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,color: Color(0xff2B2B2B),)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.03,),
              ],
            ),
          ),
        ):
        bottom_index==1 ?
        AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Notification",style: _const.manrope_regular263238(20, FontWeight.w800)),

          actions: [

          ],
        ):
        bottom_index==2 ?
        AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Selling",style: _const.manrope_regular263238(20, FontWeight.w800)),

          actions: [


          ],
        )
            :
        bottom_index==3 ?
        AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("My Account",style: _const.manrope_regular263238(20, FontWeight.w800)),

          actions: [

            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Checkout.routename);
              },
              child: Container(
                child: Image.asset('images/cart.png',color: Color(0xff263238)),
              ),
            ),
          ],

        )
            :

        AppBar(
          elevation: 0.5,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: false,

          leading: Container(
            alignment: Alignment.center,
            child: Text("Profile",style: _const.manrope_regular263238(24, FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(Setting.routename);
                },
                child:
                Container(
                    margin: EdgeInsets.only(right: width*0.05),
                    child: Icon(Icons.settings,color: Color(0xff263238),size: 30))),

          ],
        )

        ,
        body:
        fetched?
        PageView.builder(
            itemCount: 5,
            controller: bottom_controller,
            onPageChanged: (page){

              setState(() {
                bottom_index= page;
              });
             },
            itemBuilder:(context,position){
              return bottom_index==0?

              HomeScreen(all_products:all_products,
                browse_products: browse_products,
                banner: _bannerAd,
                ad_loaded: ad_loaded,
              ):
              bottom_index==1?
                  NotificationScreen():
                  bottom_index==2?
                      SellingBottomBar():
                      bottom_index==3?
                          Conversation():
                          ViewProfile()
              ;

            }):
        Container(
          height: height*1,
 width: width*1,

          child: Center(
            child: SpinKitCircle(
              color: mycolor,
            ),
          ),
        )
        ,
        bottomNavigationBar:
        fetched?
        MyBottomNavigationBar():Text("") ,
      ),
    );
  }
}
