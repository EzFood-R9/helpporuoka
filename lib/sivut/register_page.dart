// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ezfood/components/my_button.dart';
import 'package:ezfood/components/my_textfield.dart';
import 'package:ezfood/components/square_tile.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String errorText = '';

  // sign user up method
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
        // ignore: use_build_context_synchronously
        Navigator.pop(context); // add this line
        setState(() {
          errorText = '';
        });
      } else {
        setState(() {
          errorText = "Salasanat eivät täsmää";
        });
        // pop the loading circle
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        setState(() {
          errorText = "Sähköpostiosoite on jo käytössä";
        });
      } else {
        setState(() {
          errorText = "Virheellinen sähköpostiosoite.";
        });
      }
    } catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      setState(() {
        errorText = "Tapahtui virhe.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/emptytausta.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // logo
                Image.asset(
                  'assets/images/logo2.png',
                  width: 200,
                  height: 200,
                ),

                const SizedBox(height: 20),

                Text(
                  'Rekisteröidy',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 20),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Sähköpostiosoitteesi',
                  obscureText: false,
                  onChanged: (value) {},
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Salasana',
                  obscureText: true,
                  onChanged: (value) {
                    if (value.length < 6) {
                      setState(() {
                        errorText =
                            "Salasanan täytyy olla vähintään 6 merkkiä pitkä.";
                      });
                    } else {
                      setState(() {
                        errorText = '';
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
// confirm password textfield
                Column(
                  children: [
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Salasana uudelleen',
                      obscureText: true,
                      onChanged: (value) {},
                    ),
                    if (errorText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          errorText,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),

                const SizedBox(height: 40),

                // sign in button
                MyButton(
                  text: "Luo tunnus",
                  onTap: signUserUp,
                ),

                const SizedBox(height: 25),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Tai jatka',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // google button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png',
                    ),
                    SizedBox(width: 0),
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Onko sinulla jo tunnukset?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Kirjaudu sisään.',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
