import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_mob/pages/accueil_page.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController _utilisateurController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),
      body: Padding(
        padding: const EdgeInsets.all(22.44),
        child: ListView(
          children: <Widget>[
            const Text(
              'Inscription !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Veuillez saisir ces différentes informations,\nafin que vos listes soient sauvegardées.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _utilisateurController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.24,
                fontFamily: 'Proxima Nova',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'E-mail',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.24,
                fontFamily: 'Proxima Nova',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.24,
                fontFamily: 'Proxima Nova',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _password2Controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Vérification du mot de passe',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.24,
                fontFamily: 'Proxima Nova',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                    99, 106, 245, 1.0)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('S\'inscrire'),
              onPressed: () async {
                try {
                  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  // L'utilisateur a été créé avec succès.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Accueil()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('Le mot de passe est trop faible.');
                  } else if (e.code == 'email-already-in-use') {
                    print('Cette adresse e-mail est déjà utilisée.');
                  }
                } catch (e) {
                  print(e);
                }
                //BlocProvider.of<UserBloc>(context).add(ConnectUserEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}