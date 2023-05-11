
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarchantSignUp extends StatefulWidget {
  static const routename="MarchantSignUp";

  MarchantSignUp({Key? key}) : super(key: key);

  @override
  State<MarchantSignUp> createState() => _MarchantSignUpState();
}

class _MarchantSignUpState extends State<MarchantSignUp> {
  String ? url="https://developer.pbshippingmerchant.pitneybowes.com/create/accountInfo?developerID=85045805";
  @override
  Widget build(BuildContext context) {

    return  WebView(
      onPageFinished: (value){
        print("onPageFinished value is "+value.toString());

      },
      onPageStarted: (value){
        print("onPageStarted value is "+value.toString());
        if(value=="https://dingzo-api.herokuapp.com/accountlinks/success/?format=json"){
          print("succeded");
          Navigator.pop(context,'success');
        }
        else if (value=="https://dingzo-api.herokuapp.com/accountlinks/failure/?format=json"){
          print("failed");
          Navigator.pop(context,'failed');
        }
      },
      onWebViewCreated: (value){
        print("onWebViewCreated value is "+value.toString());
      },
      onProgress: (value){
        print("onProgress value is "+value.toString());
      },
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: url,
    );
  }
}
