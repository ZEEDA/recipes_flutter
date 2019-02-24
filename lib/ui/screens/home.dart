import 'package:flutter/material.dart';

import 'package:recipes_app/model/recipe.dart';
import 'package:recipes_app/utils/store.dart';
import 'package:recipes_app/ui/widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = getRecipes();
  List<String> userFavorites =getFavoritesIDs();

  void _handleFavoritesListChanged(String recipeID){
    setState(() {
      if (userFavorites.contains(recipeID)) {
        userFavorites.remove(recipeID);
      } else {
        userFavorites.add(recipeID);
      }
    });
  }

  @override
  Widget build(BuildContext context){
    Padding _buildRecipes(List<Recipe> recipesList) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: recipesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new RecipeCard(
                    recipe: recipesList[index],
                    inFavorites: userFavorites.contains(recipesList[index].id),
                    onFavoriteButtonPressed: _handleFavoritesListChanged,
                  );
                },
              ),
            )
          ],
        ),
      );
    }
    
    double _iconSize = 20.0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          // We set Size equal to passed height (50.0) and infinite width:
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.restaurant, size: _iconSize,)),
                Tab(icon: Icon(Icons.local_drink, size: _iconSize,)),
                Tab(icon: Icon(Icons.favorite, size: _iconSize,)),
                Tab(icon: Icon(Icons.settings, size: _iconSize,)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: TabBarView(
            // Placeholders for content of tabs:
            children: [
              // Display recipes of type food:
              _buildRecipes(recipes
                .where((recipe) => recipe.type ==RecipeType.food)
                .toList()
              ),

              _buildRecipes(recipes
                .where((recipe) => recipe.type == RecipeType.drink)
                .toList()
              ),

              _buildRecipes(recipes
                .where((recipe) => userFavorites.contains(recipe.id))
                .toList()
              ),

              Center(child: Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}