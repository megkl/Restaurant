import 'dart:convert';
import 'package:aunty_kat_recipe_app/CustomWidget/OverlayCard.dart';
import 'package:aunty_kat_recipe_app/apiHandler.dart';
import 'package:aunty_kat_recipe_app/screens/recipes/products.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddRecipe extends StatefulWidget {
  AddRecipe({Key key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  DateTime _dateLaunched;
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();
  List<String> _productType = ['Mortgage Loan', 'Education Loan']; // Option 2
  String _selectedProductType;
  int selectedRadio;
  String _mySelection;

  //final String url = "http://192.168.0.31:5000/productType/getProductType";

  List data = List(); //edited line
  /*Map<String, String> data = {
                    "firstName": _firstName.text,
                    "lastName": _lastName.text,
                    "email": _email.text,
                    "DOB": _dob.text,
                    "location": _location.text,
                    "phoneNumber": _phoneNumber.text,
                  };*/

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    //_loadProductTypeList();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  _loadProductTypeList() async {
    // gets data from database
    //final response = await networkHandler.get("/products/getproducts");

    setState(() {
      // _productType = response.fromJson(response["data"]);
      //Map<String, dynamic> toJson()
    });
  }

  @override
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
              height: 10,
            ),
            dropDownButton(),
            radioButton(),
            dateTextField(),
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

  Widget dropDownButton() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: DropdownButton(
          /*hint: Text('Please Choose Product Type'),
        items: data.map((item) {
          return new DropdownMenuItem(
            child: new Text(item['productTypeName']),
            value: item['_id'].toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _mySelection = newVal;
          });
        },
        value: _mySelection,
      ),*/
          hint:
              Text('Please Choose Product Type'), // Not necessary for Option 1
          value: _selectedProductType,
          onChanged: (newValue) {
            setState(() {
              _selectedProductType = newValue;
            });
          },
          items: _productType.map((productType) {
            return DropdownMenuItem(
              child: new Text(productType),
              value: productType,
            );
          }).toList(),
        ));
  }

  Widget radioButton() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("activate product"),
        Radio(
          value: 1,
          groupValue: selectedRadio,
          activeColor: Colors.blue,
          onChanged: (val) {
            print("Radio $val");
            setSelectedRadio(val);
          },
        ),
        Text("Inactivate Product"),
        Radio(
          value: 2,
          groupValue: selectedRadio,
          activeColor: Colors.blue,
          onChanged: (val) {
            print("Radio $val");
            setSelectedRadio(val);
          },
        ),
      ],
    );
  }

  Widget dateTextField() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(_dateLaunched == null
          ? 'Choose date of product launch'
          : _dateLaunched.toString()),
      IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: Colors.blue,
        ),
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate:
                      (_dateLaunched) == null ? DateTime.now() : _dateLaunched,
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2030))
              .then((date) {
            setState(() {
              date = _dateLaunched;
            });
          });
        },
      )
    ]);
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (_imageFile != null && _globalkey.currentState.validate()) {
          Map<String, String> data = {
            "title": _title.text,
            "body": _body.text,
            "productType": _selectedProductType,
          };
          var response = await networkHandler.post("/product/Add", data);
          print(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            String id = json.decode(response.body)["data"];
            var imageResponse = await networkHandler.patchImage(
                "/product/add/coverImage/$id", _imageFile.path);
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
