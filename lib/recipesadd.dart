import 'dart:async';
import 'publicrecipes.dart';
import 'package:flutter/material.dart';

import 'src/widgets.dart';

class recipesadd extends StatefulWidget {
  const recipesadd({super.key, required this.addingrecipe});

  final FutureOr<void> Function(
      String name, String materials, String instructions) addingrecipe;

  @override
  State<recipesadd> createState() => _recipesaddBookState();
}

class _recipesaddBookState extends State<recipesadd> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_recipesBookState');

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  /*Widget _buildName() {
    return null;
  }
Widget _buildMaterials() {
    return null;
  }*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Name',
                fillColor: Color.fromARGB(255, 158, 158, 158),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _controller2,
              decoration: const InputDecoration(
                hintText: 'Materials',
                fillColor: Color.fromARGB(255, 158, 158, 158),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter needed Materials';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _controller3,
              decoration: const InputDecoration(
                hintText: 'Instructions',
                fillColor: Color.fromARGB(255, 158, 158, 158),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Instructions';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            const SizedBox(width: 8),
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await widget.addingrecipe(
                      _controller.text, _controller2.text, _controller3.text);

                  _controller.clear();
                  _controller2.clear();
                  _controller3.clear();
                }
              },
              child: Row(
                children: const [
                  Icon(Icons.send),
                  SizedBox(width: 15),
                  Text('CREATE'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
