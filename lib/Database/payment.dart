import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
class PaymentDatabase{


  Future<String?> CreateSelerAccount()async{

    String ? accountid='';

    String url="https://dingzo-api.herokuapp.com/accounts/";

    var response=await http.post(Uri.parse(url),

        body: {

        }
    );
    print("ali status is "+response.body.toString());
    Map data=jsonDecode(response.body);

    accountid=data['id'];
    return accountid;

  }
  Future<String?> getAccountLink(String useraccountid)async{

    String ? link='';

    String url="https://dingzo-api.herokuapp.com/accountlinks/";

    var response=await http.post(Uri.parse(url),

        body: {
            "account_id":useraccountid
        }
    );
    var data=jsonDecode(response.body);

    print("response is "+data.toString());
    link=data['url'];
    print("url  is "+link.toString());
    return link;

  }
  Future<void> releasefund(String useraccountid)async{
    print("hello");

    String url="https://api.stripe.com/v1/payment_intents/pi_3M16seAWdh8XTc5i1i4OaAsA/capture";
    var headers = {
      'Authorization':
      'Bearer sk_test_51IGzrSAWdh8XTc5i5j1vNDw4bbwYRZgAbdVwB4LEouLANRFcerYWv1tKDgOuW6RRm4vdr9N3LrUTlWvkpIQDKEa5005qLPLMOf',

    };
    var response=await http.get(Uri.parse(url),
        headers: headers,
    );
    var data=jsonDecode(response.body);

    print("lala response is "+data.toString());


  }
}

PaymentDatabase paymentdatabase=PaymentDatabase();