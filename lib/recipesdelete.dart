import 'dart:async';
import 'package:flutter/material.dart';
import 'src/widgets.dart';
import 'publicrecipes.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

class RecipesDelete extends StatefulWidget {
  const RecipesDelete(
      {super.key, required this.deletingRecipe, required this.recipeslist});

  final FutureOr<void> Function(String name) deletingRecipe;
  final List<PublicRecipe> recipeslist;

  @override
  State<RecipesDelete> createState() => _RecipesDeleteState();
}

class _RecipesDeleteState extends State<RecipesDelete> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RecipesDeleteState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            for (var recipe in widget.recipeslist.where((recipes) =>
                recipes.userId == FirebaseAuth.instance.currentUser!.uid))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'nimi: ${recipe.name}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Poista resepti "${recipe.name}"'),
                          content: Text(
                              'Oletko varma että haluat poistaa reseptin?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Peruuta'),
                            ),
                            TextButton(
                              onPressed: () async {
                                //print(recipe.name);
                                await widget.deletingRecipe(recipe.name);
                                Navigator.pop(context);
                              },
                              child: Text('Poista'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
