// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) {
  return RecipeModel(
    coverImage: json['coverImage'] as String,
    ingredients: json['ingredients'] as String,
    duration: json['duration'] as String,
    procedure: json['procedure'] as String,
    productTypeName: json['productType'] as String,
    id: json['_id'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      'status': instance.procedure,
      'dateLaunched': instance.ingredients,
      '_id': instance.id,
      'productType': instance.productTypeName,
      'duration': instance.duration,
      'title': instance.title,
      'body': instance.body,
    };
