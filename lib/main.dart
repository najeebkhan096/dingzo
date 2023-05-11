import 'package:dingzo/Address/location.dart';
import 'package:dingzo/Address/set_up_address.dart';
import 'package:dingzo/ForgetPassword/email.dart';
import 'package:dingzo/ForgetPassword/newpassword.dart';
import 'package:dingzo/ForgetPassword/otp.dart';
import 'package:dingzo/RequestTimeChange.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/location/google_places_api.dart';
import 'package:dingzo/notificationservice/local_notification_service.dart';
import 'package:dingzo/screens/BuyerRating.dart';
import 'package:dingzo/screens/EditAccount.dart';
import 'package:dingzo/screens/NegotiatePickupTimeChange.dart';
import 'package:dingzo/screens/PaymentWebView.dart';
import 'package:dingzo/screens/SelectCategory.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/buying/Buyer_Sell_order/Buyer_Sell_Home.dart';
import 'package:dingzo/screens/buying/BuyingDetail.dart';
import 'package:dingzo/screens/buying/BuyingHomePage.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/categories.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/screens/chat/conversation.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:dingzo/screens/draft.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/edititem.dart';
import 'package:dingzo/screens/editpayment.dart';
import 'package:dingzo/screens/editprofile.dart';
import 'package:dingzo/screens/feedback.dart';
import 'package:dingzo/screens/feedback2.dart';
import 'package:dingzo/screens/finish.dart';
import 'package:dingzo/screens/helpcenter.dart';
import 'package:dingzo/screens/helpcenter2.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/screens/home/search.dart';
import 'package:dingzo/screens/live_item.dart';
import 'package:dingzo/screens/marchantportal/marchant_signup.dart';
import 'package:dingzo/screens/mylikes.dart';
import 'package:dingzo/screens/newest.dart';
import 'package:dingzo/screens/notification.dart';
import 'package:dingzo/screens/onboarding.dart';
import 'package:dingzo/screens/order_screen.dart';
import 'package:dingzo/screens/request_item/edit_request.dart';
import 'package:dingzo/screens/request_item/request_detail_Screen.dart';
import 'package:dingzo/screens/request_item/request_item.dart';
import 'package:dingzo/screens/request_item/my_requests.dart';
import 'package:dingzo/screens/request_item/posted_success.dart';
import 'package:dingzo/screens/resolution_center/resolution_centre.dart';
import 'package:dingzo/screens/profile.dart';
import 'package:dingzo/screens/searchpage.dart';
import 'package:dingzo/screens/selling/OrderProcessed.dart';
import 'package:dingzo/screens/selling/SellerSell_Item_Detail_Page/seller_sell_item_detail_page.dart';
import 'package:dingzo/screens/selling/Seller_Rent_Item_Detail_Page/Seller_Rent_Item_Detail_Page.dart';

import 'package:dingzo/screens/selling/SellingHome/SellingHomePage.dart';
import 'package:dingzo/screens/selling/selling_bottom_bar.dart';
import 'package:dingzo/screens/setting.dart';
import 'package:dingzo/screens/shirts.dart';
import 'package:dingzo/screens/shopping.dart';
import 'package:dingzo/Authentication/signup.dart';
import 'package:dingzo/Authentication/signup_welcome.dart';
import 'package:dingzo/Authentication/splash.dart';
import 'package:dingzo/screens/topratedseller.dart';
import 'package:dingzo/screens/viewitem.dart';
import 'package:dingzo/screens/viewprofile.dart';
import 'package:dingzo/screens/vocation_mode.dart';
import 'package:dingzo/screens/welcome.dart';
import 'package:dingzo/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Database/auth.dart';
import 'screens/sellerAccountCreation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

}

Future<void> main() async {

try{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  MobileAds.instance.initialize();

  Stripe.publishableKey = 'pk_test_51IGzrSAWdh8XTc5iomOO4TlK0CZHDKcwOAlEarALXG6yldF7otPmXUQ0HdZwiS5S90qLZhIFYimoMTAg3NmolPkR00JHrjuSuc';

  await Stripe.instance.applySettings();
  LocalNotificationService.initialize();
  runApp( MyApp());

} catch(error){

  print("error occured is "+error.toString());

}

}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        Provider<AuthService>(create: (_)=>AuthService()),

      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        home: Splash_Screen(),

        routes: {
          'SearchProducts_Screen':(context)=>SearchProducts_Screen(),
          'Edit_Request_Item':(context)=>Edit_Request_Item(),
          'GoogleMapsScreenApi':(context)=>GoogleMapsScreenApi(),
          'SellingBottomBar':(context)=>SellingBottomBar(),
          'LiveItem':(context)=>LiveItem(),
          'Onboarding':(context)=>Onboarding(),
          'LocationScreen':(context)=>LocationScreen(),
'Set_up_Address':(context)=>Set_up_Address(),
          'Enter_new_password':(context)=>Enter_new_password(),
          'Email_Screen':(context)=>Email_Screen(),
          'OTP_Screen':(context)=>OTP_Screen(),
          'Feedback2':(context)=>Feedback2(),
          'Request_Detail_Screen':(context)=>Request_Detail_Screen(),
          'Posted_Success':(context)=>Posted_Success(),
          'My_Request_Items':(context)=>My_Request_Items(),
          'Post_Request_Item':(context)=>Post_Request_Item(),
          'ViewItem':(context)=>ViewItem(),
          'EditItem':(context)=>EditItem(),
          'MarchantSignUp':(context)=>MarchantSignUp(),
          'BuyerRating':(context)=>BuyerRating(),
          'PaymentWebView':(context)=>PaymentWebView(),
          'AccountCreation':(context)=>AccountCreation(),
          'EditAccount':(context)=>EditAccount(),
          'VocationMode':(context)=>VocationMode(),
          'EditPayment':(context)=>EditPayment(),
          'EditAddress':(context)=>EditAddress(),
          'EditProfile':(context)=>EditProfile(),
          'Setting':(context)=>Setting(),
          'Wrapper':(context)=>Wrapper(),
          'CategoriesScreen':(context)=>CategoriesScreen(),
          'Chat_Screen':(context)=>Chat_Screen(),
          'SearchPage':(context)=>SearchPage(),
          'SignupWelcome':(context)=>SignupWelcome(),
          'FinishScreen':(context)=>FinishScreen(),
          'LoginScreen':(context)=>LoginScreen(),
          'SelectCategory':(context)=>SelectCategory(),
          'SignupScreen':(context)=>SignupScreen(),
          'Welcome':(context)=>Welcome(),
          'SelectCategory':(context)=>SelectCategory(),
          'HomeTesting':(context)=>HomeTesting(),
          'SearchPage':(context)=>SearchPage(),
          'SearchProducts_Screen':(context)=>SearchProducts_Screen(),
          'NegotiatePickupTmeChange':(context)=>NegotiatePickupTmeChange(),
          'Checkout':(context)=>Checkout(),
          'OrderProcessed':(context)=>OrderProcessed(),
          'Shirts_Screen':(context)=>Shirts_Screen(),
          'MyLikes':(context)=>MyLikes(),
          'NewestPage':(context)=>NewestPage(),
          'NotificationScreen':(context)=>NotificationScreen(),
          'DetailScreen':(context)=>DetailScreen(),
          'Chat_Screen':(context)=>Chat_Screen(),
          'SellItem':(context)=>SellItem(),
          'ViewProfile':(context)=>ViewProfile(),
          'Conversation':(context)=>Conversation(),
          'BuyingHomePage':(context)=>BuyingHomePage(),
          'BuyingDetail':(context)=>BuyingDetail(),
          'SellingHomePage':(context)=>SellingHomePage(),
          'Seller_Rent_item_Detail_Page':(context)=>Seller_Rent_item_Detail_Page(),
          'Seller_Sell_item_Detail_Page':(context)=>Seller_Sell_item_Detail_Page(),
          'FeedbackScreen':(context)=>FeedbackScreen(),
          'HelpCenter':(context)=>HelpCenter(),
          'HelpCenter2':(context)=>HelpCenter2(),
          'Buyer_Sell_Home_Page':(context)=>Buyer_Sell_Home_Page(),
          'Request_Pickup_Time_Change':(context)=>Request_Pickup_Time_Change()


        },
      ),
    );
  }
}
