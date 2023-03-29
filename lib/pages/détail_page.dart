import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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