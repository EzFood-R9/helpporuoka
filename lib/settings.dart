import 'package:ezfood/recipes.dart';
import 'package:ezfood/src/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipesdelete.dart';
import 'app_state.dart';
import 'src/widgets.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/emptytausta.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(6),
            children: <Widget>[
              Consumer<ApplicationState>(
                builder: (context, appState, _) => AuthFunc(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
              Expanded(
                child: Text(
                  'Delete Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Consumer<ApplicationState>(
                builder: (context, appState, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (appState.loggedIn) ...[
                      RecipesDelete(
                        deletingRecipe: appState.deleteRecipe,
                        recipeslist: appState.publicRecipes,
                      )
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
