import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:reci_go/app/models/recipe_model.dart';
import 'package:reci_go/app/models/recipee_result_model.dart';
import 'package:reci_go/app/services/recipe_service.dart';

class HomeController extends GetxController {
  final searchText = ''.obs;
  final recipes = <Recipe>[].obs;
  final isLoading = false.obs;
  final isLoadingRecipee = false.obs;
  final error = Rxn<String>();
  final selectedIngredients = <Recipe>[].obs;
  final recipeeData = <RecipeResult>[].obs;

  void search(String query) {
    searchText.value = query;
    fetchRecipes();
  }

  bool hasSelectedIngredients() {
    return selectedIngredients.isNotEmpty;
  }

  bool isIngredientSelected(int index) {
    final recipe = recipes[index];
    return selectedIngredients.contains(recipe);
  }

  void toggleIngredientSelection(int index) {
    final recipe = recipes[index];
    if (isIngredientSelected(index)) {
      selectedIngredients.remove(recipe);
    } else {
      selectedIngredients.add(recipe);
    }
  }

  List<String> getSelectedIngredients() {
    return selectedIngredients.map((recipe) => recipe.title).toList();
  }
void removeSelectedIngredient(Recipe recipe) {
    selectedIngredients.remove(recipe);
  }
void generateRecipes() async {
  isLoadingRecipee.value = true;
  try {
    final selectedIngredientTitles = getSelectedIngredients();
    final selectedIngredientQuery = selectedIngredientTitles.join(',');
    final recipes = await RecipeService.getRecipesByIngredients(selectedIngredientQuery);
    recipeeData.assignAll(recipes);
    error.value = null;
  } catch (e) {
    print('Error generating recipes: $e');
    error.value = 'Failed to generate recipes. Please try again later.';
  } finally {
    isLoadingRecipee.value = false;
  }
}

  void fetchRecipes() async {
    isLoading.value = true;
    try {
      // var connectivityResult = await Connectivity().checkConnectivity();
      // if (connectivityResult == ConnectivityResult.none) {
      //   throw Exception('No internet connection');
      // }

      final results = await RecipeService.searchRecipes(searchText.value);
      recipes.assignAll(results);
      error.value = null;
    } catch (e) {
      print('Error fetching recipes: $e');
      error.value = 'Failed to fetch increadiance. Please try again later.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(error, (error) {
      if (error != null) {
        // Handle error here, like showing a snackbar
        print('Error: $error');
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
