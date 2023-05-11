import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';

class ChatReciever{
  final String ?chatid;
final MyUser ? user;
final Product ? product;

ChatReciever({required this.chatid,required  this.user,required this.product,});
}