import 'package:flutter/material.dart';
import 'package:projet_mob/pages/inscription_page.dart';
import 'package:projet_mob/pages/like_page.dart';
import 'package:projet_mob/pages/recherche_page.dart';
import 'package:projet_mob/pages/wishlist_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'avis_page.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final events =[
  {
  "intitule": "Métro 1",
  "type": "metro",
  "logo": "M1.jpg"
},
{
"intitule": "Métro 2",
"type": "metro",
"logo": "M2.png"
},
{
"intitule": "Tramway R",
"type": "tram",
"logo": "TR.jpg"
},
{
"intitule": "Tramway T",
"type": "tram",
"logo": "TT.jpg"
}
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title :
        const Text("Accueil"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {   Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_,__,___) => Like()
                )
            );
            },
          ),
          IconButton(
            icon: Icon(Icons.star_border, color: Colors.white),
            onPressed: () {   Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_,__,___) => Wishlist()
                )
            );
              },
          ),
        ],

        ),
      body:


        Center(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Rechercher un jeu...',
                    hintText: 'rentre message',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "tu dois compléter le texte";
                    }
                    return null;
                  },
                   /* actions: [
                      IconButton(
                    icon: Icon(Icons.star_border, color: Colors.white),
                    onPressed: () {   Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_,__,___) => Recherche()
                        )
                    );
                    },
                  ),]*/
                ),

              ]
        )


        )
      );




  }
}

