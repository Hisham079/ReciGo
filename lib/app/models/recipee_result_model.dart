class RecipeResult {
  final int id;
  final String title;
  final String image;
  final String imageType;
  final int usedIngredientCount;
  final int missedIngredientCount;
  final List<Ingredient> missedIngredients;
  final List<Ingredient> usedIngredients;
  final List<Ingredient> unusedIngredients;
  final int likes;

  RecipeResult({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    required this.usedIngredientCount,
    required this.missedIngredientCount,
    required this.missedIngredients,
    required this.usedIngredients,
    required this.unusedIngredients,
    required this.likes,
  });

  factory RecipeResult.fromJson(Map<String, dynamic> json) {
    return RecipeResult(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
      usedIngredientCount: json['usedIngredientCount'],
      missedIngredientCount: json['missedIngredientCount'],
      missedIngredients: List<Ingredient>.from(json['missedIngredients'].map((x) => Ingredient.fromJson(x))),
      usedIngredients: List<Ingredient>.from(json['usedIngredients'].map((x) => Ingredient.fromJson(x))),
      unusedIngredients: List<Ingredient>.from(json['unusedIngredients'].map((x) => Ingredient.fromJson(x))),
      likes: json['likes'],
    );
  }
}

class Ingredient {
  final int id;
  final double amount;
  final String unit;
  final String unitLong;
  final String unitShort;
  final String aisle;
  final String name;
  final String original;
  final String originalName;
  final List<String> meta;
  final String image;

  Ingredient({
    required this.id,
    required this.amount,
    required this.unit,
    required this.unitLong,
    required this.unitShort,
    required this.aisle,
    required this.name,
    required this.original,
    required this.originalName,
    required this.meta,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      amount: json['amount'].toDouble(),
      unit: json['unit'],
      unitLong: json['unitLong'],
      unitShort: json['unitShort'],
      aisle: json['aisle'],
      name: json['name'],
      original: json['original'],
      originalName: json['originalName'],
      meta: List<String>.from(json['meta'].map((x) => x)),
      image: json['image'],
    );
  }
}
