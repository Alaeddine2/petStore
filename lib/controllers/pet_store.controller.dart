import 'package:get/get.dart';
import 'package:petstore/data/constants.dart';
import 'package:petstore/models/Category_model.dart';
import 'package:petstore/models/Tag_model.dart';
import 'package:petstore/models/pet_model.dart';
import 'package:petstore/services/pet_service.dart';

class PetStoreController extends GetxController {
  var pets = <Pet>[].obs; //using obs from Getx to make pets observable (tracked from UI)
  List<Pet> allPets = []; //I will using this variable to store all pets
  var currentStatusValue = ''.obs; //I will using this variable to control status dropdownList in update page


  @override
  void onInit() {
    super.onInit();
    print('init');
    fetchPets();
    //fetchPetsTest();
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
}