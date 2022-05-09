import 'package:dingzo/rating/rating.dart';
import 'package:dingzo/screens/BuyerRating.dart';
import 'package:dingzo/screens/CloseThisReturn.dart';
import 'package:dingzo/screens/ContinueToChase.dart';
import 'package:dingzo/screens/DetailScreenOFF.dart';
import 'package:dingzo/screens/EditAccount.dart';
import 'package:dingzo/screens/MakeAnOffer.dart';
import 'package:dingzo/screens/Refunded.dart';
import 'package:dingzo/screens/RequestReturn.dart';
import 'package:dingzo/screens/SelectCarier.dart';
import 'package:dingzo/screens/SelectCategory.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/SoldSellerEnd.dart';
import 'package:dingzo/screens/buying/BuyingHomePage.dart';
import 'package:dingzo/screens/buying/rating.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/categories.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/screens/chat/conversation.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/close%20account.dart';
import 'package:dingzo/screens/congratulation.dart';
import 'package:dingzo/screens/contactsus.dart';
import 'package:dingzo/screens/detailscreen.dart';
import 'package:dingzo/screens/draft.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/screens/editpayment.dart';
import 'package:dingzo/screens/editprofile.dart';
import 'package:dingzo/screens/feedback.dart';
import 'package:dingzo/screens/feedback2.dart';
import 'package:dingzo/screens/finish.dart';
import 'package:dingzo/screens/followers.dart';
import 'package:dingzo/screens/following.dart';
import 'package:dingzo/screens/helpcenter.dart';
import 'package:dingzo/screens/helpcenter2.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/screens/mylikes.dart';
import 'package:dingzo/screens/newest.dart';
import 'package:dingzo/screens/notification.dart';
import 'package:dingzo/screens/onboarding.dart';
import 'package:dingzo/screens/order_screen.dart';
import 'package:dingzo/resolution_center/resolution_centre.dart';
import 'package:dingzo/screens/profile.dart';
import 'package:dingzo/screens/searchpage.dart';
import 'package:dingzo/screens/selling/OrderProcessed.dart';
import 'package:dingzo/screens/selling/SellingHomePage.dart';
import 'package:dingzo/screens/setting.dart';
import 'package:dingzo/screens/shirts.dart';
import 'package:dingzo/screens/shopping.dart';
import 'package:dingzo/Authentication/signup.dart';
import 'package:dingzo/Authentication/signup_welcome.dart';
import 'package:dingzo/Authentication/splash.dart';
import 'package:dingzo/screens/topratedseller.dart';
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

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51K1GtiD5z0PA4b4fVeiLsLZeybhP8WNeFOf4If4PMWgTDVhAlHR3C1h2i9IeVRl0yWjUDmrccpgR3Is3qjKYNcG700YBFcIehs';

  await Stripe.instance.applySettings();
  runApp( MyApp());
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
          'HomeScreen':(context)=>HomeScreen(),
          'SearchPage':(context)=>SearchPage(),
          'CartScreen':(context)=>CartScreen(),
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
          'Conversation':(context)=>Conversation()

        },
      ),
    );
  }
}
