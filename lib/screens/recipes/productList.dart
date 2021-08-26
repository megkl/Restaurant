import 'package:aunty_kat_recipe_app/models/SuperModel.dart';
import 'package:aunty_kat_recipe_app/models/recipe.dart';
import 'package:aunty_kat_recipe_app/screens/recipes/editProduct.dart';
import 'package:aunty_kat_recipe_app/screens/recipes/productDetail.dart';
import 'package:aunty_kat_recipe_app/screens/recipes/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../apiHandler.dart';

class Recipes extends StatefulWidget {
  Recipes({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<RecipeModel> data = [];
  RecipeModel recipeModel = RecipeModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => RecipeDetails(
                                          recipeModel: item,
                                          networkHandler: networkHandler,
                                        )));
                          },
                          child: Column(
                            children: [
                              RecipeDetails(
                                recipeModel: item,
                                networkHandler: networkHandler,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        showDeleteAlert(context, item),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => editProduct(recipeModel),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any Products Yet"),
          );
  }

  showDeleteAlert(BuildContext context, item) {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.purple),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes", style: TextStyle(color: Colors.purple)),
      onPressed: () async {
        Navigator.pop(context);
        var response =
            await networkHandler.delete("/product/delete/${recipeModel.id}");
        print(response.body);
        if (response.statusCode == 200) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RecipesScreen()));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this product?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  editProduct(addBlogModel) {
    var title = addBlogModel.title;
    var body = addBlogModel.body;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditRecipe(
                  title: title,
                  body: body,
                )));
  }
}
