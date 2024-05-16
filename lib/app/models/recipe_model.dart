class Recipe {
  final int id;
  final String title;
  final String imageType;

  Recipe({
    required this.id,
    required this.title,
    required this.imageType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['name'],
      imageType: json['image'].split('.').last,
    );
  }
}
