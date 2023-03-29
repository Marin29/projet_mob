import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title :
          const Text("Recherche"),

        )
    );
  }
}