import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Avis extends StatefulWidget {
  const Avis({Key? key}) : super(key: key);

  @override
  State<Avis> createState() => _AvisState();
}

class _AvisState extends State<Avis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title :
          const Text("Détail du jeu"),

        )
    );
  }
}