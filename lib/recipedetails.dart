import 'package:flutter/material.dart';

import 'publicrecipes.dart';

class RecipeDetails extends StatelessWidget {
  final PublicRecipe recipe;

  const RecipeDetails({ Key? key,  required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> materials = recipe.materials.split(', ');
    List<String> instructions = recipe.instructions.split(', ');

        return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.imgurl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ingredients:', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: materials.length,
                  itemBuilder: (context, index) => Text(materials[index]),
                ),
                SizedBox(height: 16),
                Text('Instructions:', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: instructions.length,
                  itemBuilder: (context, index) => Text('${index + 1}. ${instructions[index]}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}