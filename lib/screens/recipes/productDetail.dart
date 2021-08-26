import 'package:aunty_kat_recipe_app/models/recipe.dart';
import 'package:flutter/material.dart';

import '../../apiHandler.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({Key key, this.recipeModel, this.networkHandler})
      : super(key: key);
  final RecipeModel recipeModel;
  final NetworkHandler networkHandler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 365,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: networkHandler.getImage(recipeModel.id),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      recipeModel.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        /*Text(
                          addBlogModel.comment.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.thumb_up,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          addBlogModel.count.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.share,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          addBlogModel.share.toString(),
                          style: TextStyle(fontSize: 15),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: ListTile(
                  title: Text(recipeModel.body),
                  //subtitle: Text(addBlogModel.status),
                ),
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.purple,
                child: Text(
                  "Apply for loan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
