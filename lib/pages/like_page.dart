import 'package:flutter/material.dart';
import 'package:projet_mob/pages/recherche_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title :
          const Text("Mes likes"),

        )
    );
  }
}
