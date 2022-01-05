import 'dart:convert';

import 'package:chat/models/User.dart';
import 'package:http/http.dart' as http;

Future<List<User>> getAllUser() async {
  String stringUrl = "http://192.168.0.181:8000/api/getAllUser";
  Uri url = Uri.parse(stringUrl);
  var response = await http.post(
    url,
    body: {
      'loggedInUserId' : 1.toString(),
    },
    headers: {
      'Accept' : 'application/json',
    },
  );

  List<User> userList = [];
  if(response.statusCode == 200){
    var json = jsonDecode(response.body);
    userList = (json as List).map((e) => User.fromJson(e)).toList();

    return userList;
  }else{
    return userList;
  }
}

void sendMessage(int receiverUserID, String textMessage) async {
  String stringUrl = "http://192.168.0.181:8000/api/chat/sendMessage";
  Uri url = Uri.parse(stringUrl);
  var response = await http.post(
    url,
    body: {
      'senderUserID' : 1.toString(), // to set current logged in user
      'receiverUserID' : receiverUserID.toString(),
      'chatMessage' : textMessage,
    },
    headers: {
      'Accept' : 'application/json',
    },
  );

  print(response.body);
}

void getChatUser(int receiverUserID) async {
  String stringUrl = "http://192.168.0.181:8000/api/chat/getUserChat";
  Uri url = Uri.parse(stringUrl);
  var response = await http.post(
    url,
    body: {
      'senderUserID' : 1.toString(), // to set current logged in user
      'receiverUserID' : receiverUserID.toString(),
    },
    headers: {
      'Accept' : 'application/json',
    },
  );

  print(response.body);
}
