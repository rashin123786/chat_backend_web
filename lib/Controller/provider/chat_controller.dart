import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../Model/message_model.dart';

class AdminChatController with ChangeNotifier {
  List<MessageModel> messageModeList = [];
  void getMessage(id) async {
    log("this is the id : $id");
    //  final getUserId = FirebaseFirestore.instance.collection('newuser')
    List<MessageModel> listmessage = [];
    final getmessage = await FirebaseFirestore.instance
        .collection("messages")
        .doc(id.toString())
        .collection("chats")
        .orderBy('timestamp', descending: true)
        .get();
    log("after get $id");
    for (var element in getmessage.docs) {
      MessageModel messageModel = MessageModel(
        dateTime: element.get("datetime"),
        message: element.get("messages"),
        timestamp: element.get("timestamp"),
        isAdmin: element.get("isadmin"),
      );
      listmessage.add(messageModel);
    }
    messageModeList = listmessage;
    notifyListeners();
  }

  List<MessageModel> get getResultMessage {
    return messageModeList;
  }
}
