import 'package:get/state_manager.dart';
import 'package:petstore/models/Category_model.dart';
import 'package:petstore/models/Tag_model.dart';

class Pet {
  int id;
  String name;
  Category? category;
  List<dynamic>? photoUrls;
  List<Tag>? tags;
  String status;

  Pet(
    {
    this.name ='', 
    this.id = 0,
    this.category,
    required this.photoUrls,
    this.tags,
    required this.status,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    final name = json['name'] == null ? 'UNKOWN' : json['name'] as String;
    final status = json['status'] as String;
    final id = json['id'] as int;
    final photoUrls = json['photoUrls'] as List<dynamic>;
    final category = json['category'] == null ? null : Category.fromJson(json['category']);
    final tagList = json['tags'] == null ? null : json['tags'] as List<dynamic>;
    var tags = tagList?.map((tag) => Tag(id: tag['id'], name: tag['name'] == null ? 'Unkown' : tag['name'])).toList();
    return Pet(id: id,name: name, category: category, photoUrls: photoUrls, tags: tags, status: status);
  } 

}