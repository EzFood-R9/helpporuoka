

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'publicrecipes.dart';
import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  String placeholder = "https://media.discordapp.net/attachments/1047466096673947653/1097456196853694546/image.png";
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _publicRecipeSubscription;
  List<PublicRecipe> _publicRecipes = [];
  List<PublicRecipe> get publicRecipes => _publicRecipes;

  // Add recipes getter
  List<String> get recipes =>
      _publicRecipes.map((recipe) => recipe.name).toList();

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _publicRecipeSubscription = FirebaseFirestore.instance
            .collection('recipes')
            .orderBy('name', descending: false)
            .snapshots()
            .listen((snapshot) {
          final List<PublicRecipe> recipes = snapshot.docs.map((document) {
            return PublicRecipe(
              name: document.data()['name'] as String,
              materials: document.data()['materials'] as String,
              instructions: document.data()['instructions'] as String,
              userId: document.data()['userId'] as String,
              imgurl: document.data()['imgurl'] as String,
            );
          }).toList();
          _publicRecipes = recipes;
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _publicRecipes = [];
        _publicRecipeSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addRecipe(
      String name, String materials, String instructions) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('recipes')
        .add(<String, dynamic>{
      'name': name,
      'instructions': instructions,
      'materials': materials,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'imgurl': placeholder,
      
    });
  }

Future<void> deleteRecipe(String name) async {
  if (!_loggedIn) {
    throw Exception('Must be logged in');
  }

  // Query for the document with the matching name
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('recipes')
      .where('name', isEqualTo: name)
      .get();

  if (querySnapshot.size == 0) {
    print('No recipe found with name $name');
    return;
  }

  // Delete the first document returned by the query
  await FirebaseFirestore.instance
      .collection('recipes')
      .doc(querySnapshot.docs[0].id)
      .delete();

  print('Recipe deleted successfully!');
}}