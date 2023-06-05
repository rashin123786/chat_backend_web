import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Model/model.dart';

const background = Color.fromARGB(255, 12, 22, 54);
SizedBox sizedBox30 = SizedBox(
  height: 30,
);
SizedBox sizedBox20 = SizedBox(
  height: 20,
);
SizedBox sizedBox10 = SizedBox(
  height: 10,
);

final userCollection = FirebaseFirestore.instance.collection("user");
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
  await messagecollection.doc(id).collection("chats").add({
    "id": messagecollection.id,
    "messages": messages,
    "datetime": dateTime,
    "timestamp": timestamp,
    "isadmin": true,
  }).then((value) {
    docId = value.id;
    messagecollection.doc(id).collection("chats").doc(docId).update({
      "id": id,
    });
  });
}
