import 'dart:convert';
import 'package:aunty_kat_recipe_app/CustomWidget/OverlayCard.dart';
import 'package:aunty_kat_recipe_app/models/recipe.dart';
import 'package:aunty_kat_recipe_app/screens/recipes/products.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../apiHandler.dart';

class EditRecipe extends StatefulWidget {
  //EditProduct({Key key}) : super(key: key);
  String title;
  String body;
  EditRecipe({this.title, this.body});
  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final _globalkey = GlobalKey<FormState>();
  RecipeModel recipeModel = RecipeModel();
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  bool circular = false;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    //var response = await networkHandler.get("/product/getproducts");
    setState(() {
      _title.text = widget.title;
      _body.text = widget.body;

      // addBlogModel = AddBlogModel.fromJson(response['data']);
      circular = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (_imageFile.path != null &&
                  _globalkey.currentState.validate()) {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => OverlayCard(
                        imagefile: _imageFile,
                        title: _title.text,
                      )),
                );
              }
            },
            child: Text(
              "Preview",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )
        ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            bodyTextField(),
            SizedBox(
              height: 20,
            ),
            addButton(),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _title,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be <=100";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Add Image and Title",
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Colors.teal,
            ),
            onPressed: takeCoverPhoto,
          ),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _body,
        validator: (value) {
          if (value.isEmpty) {
            return "Body can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Describe the product",
        ),
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        if (_globalkey.currentState.validate()) {
          Map<String, String> data = {
            "title": _title.text,
            "body": _body.text,
          };
          var response = await networkHandler.patch(
              "/product/update/${recipeModel.id}", data);
          print(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (_imageFile.path != null) {
              //String id = json.decode(response.body)["data"];
              var imageResponse = await networkHandler.patchImage(
                  "/product/add/coverImage/${recipeModel.coverImage}",
                  _imageFile.path);
              print(imageResponse.statusCode);
              if (imageResponse.statusCode == 200 ||
                  imageResponse.statusCode == 201) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => RecipesScreen()),
                    (route) => true);
              }
            }
          }
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Add Product",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }
}
