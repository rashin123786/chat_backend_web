import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Model/model.dart';

const background = Color.fromARGB(255, 12, 22, 54);
const sizedBox30 = SizedBox(
  height: 30,
);
const sizedBox20 = SizedBox(
  height: 20,
);
const sizedBox10 = SizedBox(
  height: 10,
);

final userCollection = FirebaseFirestore.instance.collection("newuser");
Stream<List<UserModel>> getAlluser() {
  return userCollection.snapshots().map((event) {
    return event.docs.map((e) {
      return UserModel.fromjson(e.data() as Map<String, dynamic>);
    }).toList();
  });
}

final messagecollection = FirebaseFirestore.instance.collection("messages");
String? docId;
void addChat({
  String? id,
  String? name,
  String? messages,
  String? dateTime,
  Timestamp? timestamp,
}) async {
  print(id);
  await messagecollection.doc(id.toString()).collection("chats").add({
    "id": messagecollection.id,
    "messages": messages,
    "datetime": dateTime,
    "timestamp": timestamp,
    "isadmin": true,
  }).then((value) {
    docId = value.id;
    messagecollection.doc(id.toString()).collection("chats").doc(docId).update({
      "id": id,
    });
  });
}
