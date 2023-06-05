import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/Controller/provider/chat_controller.dart';

import 'package:todo_api/view/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDe4vuS679gI4pCsbCkD_-ie7KEPovJgvY",
        appId: "1:485263749111:web:221cf01c568b015b7988f2",
        messagingSenderId: "485263749111",
        projectId: "nexyprism"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AdminChatController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: HomeScreen(),
      ),
    );
  }
}
