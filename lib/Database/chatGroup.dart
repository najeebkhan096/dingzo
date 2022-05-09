
import 'package:dingzo/model/myuser.dart';

class ChatGroup {
  final String? groupname;
  final List<MyUser> ? members;
  final String? docid;
  final String ? url;
  ChatGroup({this.groupname, this.docid,this.members,this.url});
}