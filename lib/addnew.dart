import 'package:flutter/material.dart';
import 'recipesadd.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:provider/provider.dart';
import 'app_state.dart';

import 'src/widgets.dart';

class Addnew extends StatelessWidget {
  const Addnew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/emptytausta.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(6),
          children: <Widget>[
            // Center the text horizontally and vertically
            const Expanded(
              child: Center(
                child: Text(
                  "Add recipes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (appState.loggedIn) ...[
                    recipesadd(
                        addingrecipe: (name, materials, instructions) =>
                            appState.addRecipe(name, materials, instructions)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
