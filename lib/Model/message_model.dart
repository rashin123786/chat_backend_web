import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? id;
  final String? name;
  final String? message;
  final String? dateTime;
  final Timestamp timestamp;
  final bool? isAdmin;
  MessageModel(
      {this.dateTime,
      this.name,
      this.message,
      this.id,
      this.isAdmin,
      required this.timestamp});
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map["id"],
      message: map["messages"],
      dateTime: map["datetime"],
      timestamp: map["timestamp"],
      isAdmin: map['isadmin'],
    );
  }
}
