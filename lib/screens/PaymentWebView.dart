
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
static const routename="PaymentWebView";

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
 String ? url;
  @override
  Widget build(BuildContext context) {
    url=ModalRoute.of(context)!.settings.arguments as String;
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
