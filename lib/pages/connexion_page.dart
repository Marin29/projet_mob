/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
*/
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


//import '../../objects/user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_mob/pages/accueil_page.dart';



import 'inscription_page.dart';



class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(0xFF1A2025),
          child: Center(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 51.67),
                const Text(
                  'Bienvenue !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.53,
                    fontFamily: 'Google Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48.15),
                const Text(
                  'Veuillez vous connecter ou\ncréer un nouveau compte\npour utiliser l’application.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.27,
                    fontFamily: 'Proxima Nova',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48.15),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(22.44),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF1E262C),
                            labelText: 'E-mail',
                            alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.24,
                              fontFamily: 'Proxima Nova',
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.24,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                        const SizedBox(height: 11.72),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF1E262C),
                            labelText: 'Mot de passe',
                            alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.24,
                              fontFamily: 'Proxima Nova',
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.24,
                            fontFamily: 'Proxima Nova',
                          ),
                        ),
                        const SizedBox(height: 72.73),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(99, 106, 245, 1.0)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            child: Text('Se connecter'),
                            onPressed: () async {
                              try {
                                UserCredential userCredential =
                                await _auth
                                    .signInWithEmailAndPassword(
                                  email: _email,
                                  password: _password,
                                );
                                // L'utilisateur est connecté
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Accueil()),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            }),
                        const SizedBox(height: 15.38),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(99, 106, 245, 1.0)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            child: Text('Créer un compte'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Inscription()),
                              );
                            }),
                        // go to the NewUser screen
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*FutureBuilder<List<User>>(
                //future: UserDataBase.db.getAllUsers(),
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        User item = snapshot.data![index];
                        return ListTile(
                          title: Text(item.email),
                          subtitle: Text(item.password),
                        );
                      },
                    );
                  } else {
                    return const Text('No data');
                  }
                },
              ),*/