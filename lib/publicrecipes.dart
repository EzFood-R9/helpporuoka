

class PublicRecipe {
  PublicRecipe(
      {

      required this.userId,
      required this.name,
      required this.materials,
      required this.instructions,
      required this.imgurl});

  final String userId;
  final String name;
  final String materials;
  final String instructions;
  final String imgurl;
}
