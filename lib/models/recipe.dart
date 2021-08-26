import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class RecipeModel {
  String coverImage;
  String ingredients;
  String duration;
  String procedure;
  String productTypeName;
  String id;
  String title;
  String body;

  RecipeModel(
      {this.coverImage,
      this.ingredients,
      this.duration,
      this.procedure,
      this.id,
      this.productTypeName,
      this.body,
      this.title});
  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}
