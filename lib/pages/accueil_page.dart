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
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //User? user = FirebaseAuth.instance.currentUser;

  List<dynamic> _gameList = [];

  /*firebaseAuth() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }*/

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {

    final response = await http.get(
        Uri.parse('https://api.steampowered.com/ISteamApps/GetAppList/v2/'),
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type',
        });
    final decodedResponse = json.decode(response.body);
    setState(() {
      _gameList = decodedResponse['applist']['apps'];
    });

    /*final server = await HttpServer.bind('localhost', 8080);

    print('Listening on http://${server.address.host}:${server.port}/');

    await for (var request in server) {
      // Ajoute les en-têtes CORS
      request.response.headers.add('Access-Control-Allow-Origin', '*');
      request.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
      request.response.headers.add('Access-Control-Allow-Headers', 'Origin, Content-Type');

      // Traite la requête
      if (request.method == 'GET') {
        final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamApps/GetAppList/v2/'));
        final decodedResponse = json.decode(response.body);
        setState(() {
          _gameList = decodedResponse['applist']['apps'];
        });
      } else {
        // Renvoie une réponse 404
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not found');
      }

      // Ferme la réponse
      await request.response.close();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _gameList.length,
        itemBuilder: (context, index) {
          final game = _gameList[index];
          return Card(
            child: Column(
              children: [
                Image.network(
                  'https://cdn.akamai.steamstatic.com/steam/apps/${game['appid']}/header.jpg',
                  height: 100,
                ),
                ListTile(
                  title: Text(game['name']),
                  subtitle: Text('ID du jeu: ${game['appid']}'),
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}

