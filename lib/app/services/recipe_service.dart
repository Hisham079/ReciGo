import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reci_go/app/models/recipe_model.dart';
import 'package:reci_go/app/models/recipee_result_model.dart';

class RecipeService {
  static const apiKey = '329b8ebc3478471c8c762633bdc239d4';
  static const baseUrl = 'https://api.spoonacular.com';

  static Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/food/ingredients/search?apiKey=$apiKey&number=10&query=$query'),
    );
    print('////');
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
  static Future<List<RecipeResult>> getRecipesByIngredients(String ingredients) async {
  final response = await http.get(
    Uri.parse('$baseUrl/recipes/findByIngredients?apiKey=$apiKey&ingredients=$ingredients&number=10'),
  );
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => RecipeResult.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}
}
