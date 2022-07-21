import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore/data/constants.dart';
import 'package:petstore/models/pet_model.dart';
import 'package:dio/dio.dart';

class PetService {

  static Future<List<Pet>?> getPets(String status) async {
    try {
      List<Pet> pets = [];
      var response = await Dio().get(serverDomain + 'v2/pet/findByStatus?status=' + status);
      print(response);
      if(response.statusCode == 200){
        List<dynamic> data = response.data;
        pets = List<Pet>.from(data.map((model)=> Pet.fromJson(model)));
        return pets;
      }else{
        Get.snackbar('getting data error', 'Error...', backgroundColor: Colors.red);
        return pets;
      }
    } catch (e) {
        print(e);
        Get.snackbar('getting data error', e.toString(), backgroundColor: Colors.red);
        return [];
    }
  }

  static Future<bool> deletePet(int id) async {
    try {
      List<Pet> pets = [];
      var response = await Dio().delete(serverDomain + 'v2/pet/' + id.toString());
      print(response.statusCode);
      if(response.statusCode == 200){
        Get.snackbar('Delete...', 'deleting pet successfully');
        return true;
      }else if(response.statusCode == 404){
        Get.snackbar('Error...', 'pet not found in the store', backgroundColor: Colors.red);
        return false;
      }else{
        Get.snackbar('Error...', 'Error in deleting pet', backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
        Get.snackbar('Error...', 'pet not found in the store', backgroundColor: Colors.red);
        return false;
    }
  }

  static Future<bool> updatePet(int id, String name, String status) async {
    try {
      List<Pet> pets = [];
      var response = await Dio().post(
        serverDomain + 'v2/pet/' + id.toString(),
          data: {'name': name, 'status': status},
          options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.statusCode);
      if(response.statusCode == 200){
        Get.snackbar('Updating...', 'updating pet successfully');
        return true;
      }
      return false;
    } catch (e) {
        Get.snackbar('Error...', 'Error in deleting pet', backgroundColor: Colors.red);
        return false;
    }
  }
}