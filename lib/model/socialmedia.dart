import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';

class SocialMedia{

  final int ? followers;
  final int ? followings;
  final int ? rating;
  final int ? item;
  final List<Product> ?  forSale;
  final List<Product> ? sold;
  final List<MyUser> ? following;
  final List<MyUser>? follower;

  SocialMedia({this.follower,this.following,this.forSale,this.item,this.rating,this.sold,this.followers,this.followings});

}