import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
      var response = await Dio().delete(serverDomain + 'v2/pet/' + id.toString());
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
      var response = await Dio().post(
        serverDomain + 'v2/pet/' + id.toString(),
          data: {'name': name, 'status': status},
          options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if(response.statusCode == 200){
        Get.snackbar('Updating...', 'updating pet successfully');
        return true;
      }
      return false;
    } catch (e) {
        Get.snackbar('Error...', 'Error in updating pet', backgroundColor: Colors.red);
        return false;
    }
  }

  static Future<Pet?> addPet(String name, String status, List<String> photoImages) async {
    try {
      var response = await Dio().post(
        serverDomain + 'v2/pet/',
          data: {'name': name, 'status': status, "tags": [], "photoUrls": photoImages, "id": 0},
      );
      if(response.statusCode == 200){
        Get.snackbar('Addig...', 'Adding pet successfully');
        return Pet(photoUrls: photoImages, status: status,name: name, id: response.data['id'], tags: []);
      }
      return null;
    } catch (e) {
        Get.snackbar('Error...', 'Error in adding pet', backgroundColor: Colors.red);
        return null;
    }
  }

  static Future<String> UploadImageToThumbsnap(XFile image) async{
    try {
      var request = http.MultipartRequest('POST', Uri.parse(uploadImageServer));
      request.fields.addAll({
        'key': '00001c8646955874272198adb97ba265'
      });
      request.files.add(await http.MultipartFile.fromPath('media', image.path));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());
        return jsonResponse['data']['media'];
      }
      else {
        print(response.reasonPhrase);
      }
      return '';
    } catch (e) {
      return '';
    }
    
  }
}