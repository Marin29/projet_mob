


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_mob/pages/accueil_page.dart';
import 'package:projet_mob/pages/connexion_page.dart';
import 'package:projet_mob/pages/inscription_page.dart';

import 'firebase_options.dart';




Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  setCurrentIndex(int index){
    setState(() {
      _currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       body : Connexion()




      ),
    );
  }
}








