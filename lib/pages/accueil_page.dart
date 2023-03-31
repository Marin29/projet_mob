import 'package:flutter/material.dart';
import 'package:projet_mob/pages/inscription_page.dart';
import 'package:projet_mob/pages/like_page.dart';
import 'package:projet_mob/pages/recherche_page.dart';
import 'package:projet_mob/pages/wishlist_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'avis_page.dart';

Future<List<Rank>> fetchGames() async {
  try {
    final response = await http.get(
      Uri.https(
          'api.steampowered.com', '/ISteamChartsService/GetMostPlayedGames/v1'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
        'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );

    if (response.statusCode == 200) {
      return await _getGameDetails(
          Games.fromJson(jsonDecode(response.body)).ranks);
    } else {
      throw Exception('Failed to load games: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load games: $e');
  }
}

Future<List<Rank>> _getGameDetails(List<Rank> ranks) async {
  List<Rank> updatedRanks = [];
  for (var rank in ranks) {
    final response = await http.get(
      Uri.parse(
          'https://store.steampowered.com/api/appdetails?appids=${rank.appId}'),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody[rank.appId.toString()]['success']) {
        rank.name = jsonBody[rank.appId.toString()]['data']['name'];
        rank.header_image =
        jsonBody[rank.appId.toString()]['data']['header_image'];
      }
    }
    updatedRanks.add(rank);
  }
  return updatedRanks;
}

class Games {
  final int rollupDate;
  final List<Rank> ranks;

  Games({
    required this.rollupDate,
    required this.ranks,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      rollupDate: json['response']['rollup_date'],
      ranks: List<Rank>.from(
        json['response']['ranks'].map(
              (rankJson) => Rank.fromJson(rankJson),
        ),
      ),
    );
  }
}

class Rank {
  final int rank;
  final int appId;
  final int lastWeekRank;
  final int peakInGame;
  String? name;
  String? header_image;

  Rank({
    required this.rank,
    required this.appId,
    required this.lastWeekRank,
    required this.peakInGame,
    this.name,
    this.header_image,
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      rank: json['rank'],
      appId: json['appid'],
      lastWeekRank: json['last_week_rank'],
      peakInGame: json['peak_in_game'],
      name: json['name'],
      header_image: json['header_image'],
    );
  }
}
class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  firebaseAuth() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  late Future<List<Rank>> futureGames;

  Icon customIcon = const Icon(Icons.search);
  Icon customIconWishList = const Icon(Icons.star_border);
  Icon customIconLike = const Icon(Icons.favorite_border);
  Widget searchBar = const Text(
    'Accueil',
    style: TextStyle(
      color: Colors.white,
    ),
  );

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: const Text(
              "Accueil",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Proxima Nova',
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: customIconLike,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (MesLikes()),
                      )
                  );
                },
              ),
              IconButton(
                icon: customIconWishList,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (MesSouhaits()),
                      )
                  );
                },
              ),
            ],
          ),
          body: Container(
            color: const Color(0xFF1A2025),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1E262C),
                      hintText: 'Rechercher un jeu...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.24,
                        fontFamily: 'Proxima Nova',
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.24,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
                Center(
                  child: FutureBuilder<List<Rank>>(
                    future: futureGames,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final ranks = snapshot.data!;
                        return ListView.builder(
                          itemCount: ranks.length,
                          itemBuilder: (context, index) {
                            final rank = ranks[index];
                            return Container(
                              //child: Text('${rank.name}. ${rank.appId}'),
                                child: Image.network(
                                  '${rank.header_image}',
                                ));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

