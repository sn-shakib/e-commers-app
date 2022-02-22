
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:full_app/Details_page.dart';
import 'package:full_app/example.dart';
import 'package:full_app/splash%20screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:full_app/store_page/store_page.dart';

main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialization

  runApp(const CommersApp());
}
class CommersApp extends StatefulWidget {
   const CommersApp({Key? key}) : super(key: key);

  @override

  _CommersAppState createState() => _CommersAppState();
}
class _CommersAppState extends State<CommersApp> {
  @override

  @override

  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
