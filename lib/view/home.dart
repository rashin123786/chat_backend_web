import 'package:flutter_tts/flutter_tts.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:todo_api/Controller/constants/constants.dart';
import 'package:todo_api/Controller/provider/chat_controller.dart';
import 'package:todo_api/view/single_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String ids = '';
  @override
  Widget build(BuildContext context) {
    final adminChatProvider =
        Provider.of<AdminChatController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      adminChatProvider.getMessage(ids);
      //  totalMessage = adminChatProvider.getResultMessage.length;
      //  print(totalMessage);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Users"),
        centerTitle: true,
      ),
      backgroundColor: background,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: getAlluser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        ids = data.id ?? '';
                        return Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              adminChatProvider.getMessage(data.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleChatScreen(
                                        id: data.id ?? '',
                                        userName: data.username ?? ''),
                                  ));
                            },
                            title: Text(
                              data.username ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Text(snapshot.error.toString());
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
