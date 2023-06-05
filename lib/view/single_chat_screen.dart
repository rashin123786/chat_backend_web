import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/Controller/constants/constants.dart';

import '../Controller/provider/chat_controller.dart';

class SingleChatScreen extends StatelessWidget {
  final int id;
  final String userName;
  SingleChatScreen({super.key, required this.id, required this.userName});
  final _message = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final adminChatProvider = Provider.of<AdminChatController>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      adminChatProvider.getMessage(id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        centerTitle: true,
      ),
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              controller: scrollController,
              separatorBuilder: (context, index) {
                return sizedBox10;
              },
              itemCount: adminChatProvider.getResultMessage.length,
              itemBuilder: (context, index) {
                final data = adminChatProvider.getResultMessage[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Align(
                    alignment: data.isAdmin == true
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 253, 122),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(data.message ?? '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            sizedBox10,
                            Text(
                              "${data.timestamp.toDate().hour.toString().padLeft(2, '0')}:${data.timestamp.toDate().minute.toString().padLeft(2, '0')} ${data.timestamp.toDate().hour >= 12 ? 'pm' : 'am'} ",
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                  controller: _message,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Message')),
            ),
            trailing: GestureDetector(
              onTap: () async {
                Timestamp timestamp = Timestamp.now();

                addChat(
                  id: id,
                  dateTime: DateTime.now().toString(),
                  messages: _message.text,
                  timestamp: timestamp,
                );

                _message.clear();
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
