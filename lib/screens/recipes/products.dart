import 'package:aunty_kat_recipe_app/screens/recipes/productList.dart';
import 'package:flutter/material.dart';

import 'addProduct.dart';

class RecipesScreen extends StatefulWidget {
  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      appBar: AppBar(
        title: Text("Recipes"),
        actions: [
          FloatingActionButton(
            //backgroundColor: Colors.teal,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddRecipe()));
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Recipes(
          url: "/product/getproducts",
        ),
      ),
    );
  }
}
