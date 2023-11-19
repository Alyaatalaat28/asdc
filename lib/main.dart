import 'package:asdc/constatns.dart';
import 'package:asdc/features/walkie/presentation/views/walkie_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: "AIzaSyDlyeugJTtVMlzVI7w9R2CG1M-dbgV4rEo",
       appId:"1:1095783861496:android:2ed21239d04b262dc8bf0d" ,
        messagingSenderId: "1095783861496	",
         projectId: "decorum-e2f84"
         ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kColourPrimary,
        scaffoldBackgroundColor: kColourBackground,
      ),
      home: const WalkieView(),
    );
  }
}

