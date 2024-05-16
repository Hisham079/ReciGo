import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ReciGo'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Search'),
                onChanged: (query) => controller.search(query),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.error.value != null) {
                  return Center(child: Text(controller.error.value!));
                } else if (controller.recipes.isEmpty) {
                  return const Center(child: Text('No recipes found'));
                } else {
                  return Container(
                    color: Colors.grey,
                    child: ListView.builder(
                      itemCount: controller.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = controller.recipes[index];
                        return ListTile(
                          title: Text(recipe.title),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://spoonacular.com/recipeImages/${recipe.id}-240x150.${recipe.imageType}'),
                          ),
                          trailing: Obx(
                            () => Checkbox(
                              value: controller.isIngredientSelected(index),
                              onChanged: (selected) {
                                controller.toggleIngredientSelection(index);
                              },
                            ),
                          ),
                          onTap: () {
                            controller.toggleIngredientSelection(index);
                          },
                        );
                      },
                    ),
                  );
                }
              }),
            ),
             Obx(() {
            final selectedIngredients = controller.selectedIngredients;
            return selectedIngredients.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.grey[300],
                    child: Row(
                      children: [
                        Text(
                          'Selected Ingredients:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: selectedIngredients.map((recipe) {
                                return Row(
                                  children: [
                                    Text(recipe.title),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        controller.removeSelectedIngredient(recipe);
                                      },
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
          }),
            Obx(() {
              final hasSelectedIngredients =
                  controller.hasSelectedIngredients();
              return hasSelectedIngredients
                  ? ElevatedButton(
                      onPressed: () {
                        controller.generateRecipes();
                      },
                      child: const Text('Generate Recipes'),
                    )
                  : const SizedBox(); // If no ingredients are selected, return an empty SizedBox
            }),
            Expanded(child: Obx(
              () {
                final selectedRecipes = controller.recipeeData;
                return selectedRecipes.isNotEmpty
                    ? ListView.builder(
                        itemCount: selectedRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = selectedRecipes[index];
                          return ListTile(
                            title: Text(recipe.title),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://spoonacular.com/recipeImages/${recipe.id}-240x150.${recipe.imageType}'),
                            ),
                            onTap: () {
                              // Add any action on tapping the selected recipe
                            },
                          );
                        },
                      )
                    : const SizedBox();
              },
            ))
          ],
        ));
  }
}
