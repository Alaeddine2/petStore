import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petstore/data/constants.dart';
import 'package:petstore/models/pet_model.dart';
import 'package:petstore/services/pet_service.dart';

class PetStoreController extends GetxController {
  var pets = <Pet>[].obs; //using obs from Getx to make pets observable (tracked from UI)
  List<Pet> allPets = []; //I will using this variable to store all pets
  var currentStatusValue = ''.obs; //I will using this variable to control status dropdownList in update page
  // Image picker Instance creation
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles = <XFile>[].obs;
  var imagefilesCounter = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPets();
  }

  Future<void> fetchPets() async {
    pets.value = (await PetService.getPets(statusList[0]))!;
    allPets = pets.value;
  }

  Future<void> deletePet(int id) async{
    if(await PetService.deletePet(id)){
      pets.removeWhere((item) => item.id == id);
      allPets.removeWhere((item) => item.id == id);
    }
  }

  Future<void> updatePet(int id, String name) async{
    if(await PetService.updatePet(id, name, currentStatusValue.value)){
      int index = pets.indexWhere((element) => element.id == id);
      pets[index].name = name;
      pets[index].status = currentStatusValue.value;
      Pet pet = pets[index];  
      pets.removeWhere((item) => item.id == id);  
      pets.insert(index, pet);
      allPets = pets.value;
    }
  }

  filterPets(String val){
    pets.value = pets.where((pet) => pet.name.startsWith(val)).toList();
  }

  clearFilters(String val){
    pets.value = allPets;
  }

  Future<void> addpet(String name) async {
    //pendingDialog();
    List<String> photoImages = imagefilesCounter.value == 0 ? [] : await gettingImagesUrlList(); 
    imagefilesCounter.value = 0;
    Pet? pet = await PetService.addPet(name, currentStatusValue.value, photoImages);
    if(pet != null){
      pets.insert(0, pet);
      allPets = pets.value; 
    }
  }

  openImages() async {
    try {
        var pickedfiles = await imgpicker.pickMultiImage();
        if(pickedfiles != null){
            imagefiles = pickedfiles;
            imagefilesCounter.value = pickedfiles.length;
        }else{
            print("No image is selected.");
            imagefilesCounter.value = 0;
        }
    }catch (e) {
      imagefilesCounter.value = 0;
      print(e);
        print("error while picking file.");
    }
  }

  Future<List<String>> gettingImagesUrlList() async{
    List<String> urls = [];
    for (var image in imagefiles!) {
      urls.add(await PetService.UploadImageToThumbsnap(image));
    }
    return urls;
  } 

  pendingDialog(){
    //open a loading dialog
    Get.defaultDialog(
      title: 'Pending',
      content: SizedBox(
        width: Get.width * .8,
        height: Get.height * .3,
        child: CircularProgressIndicator(),
      )
    );
  }
}