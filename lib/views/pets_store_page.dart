import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petstore/controllers/pet_store.controller.dart';
import 'package:petstore/data/constants.dart';
import 'package:petstore/utils/theme_util.dart';
import 'package:petstore/views/edit_pet_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PetsStorePage extends StatelessWidget {

  PetsStorePage({Key? key}) : super(key: key);
  final petStoreController = Get.put(PetStoreController()); // depency injection so I can fetch pets using this controller 

  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Store', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const Text(
              "best Partner for you",
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Form(
            child: TextFormField(
              onSaved: (value) {
                print(value);
              },
              onChanged: (val) {
                if(val.length >= 2){
                  petStoreController.filterPets(val);
                }
                if(val.length < 2){
                  petStoreController.clearFilters(val);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search for a pet...",
                border: _outlineInputBorder,
                enabledBorder: _outlineInputBorder,
                focusedBorder: _outlineInputBorder,
                errorBorder: _outlineInputBorder,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SvgPicture.asset("assets/icons/Search.svg"),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: () {},
                      child: SvgPicture.asset("assets/icons/Filter.svg"),
                    ),
                  ),
                ),
              ),
            ),
            ),),
            Container(
              height: Get.height * .59,
              child: GetX<PetStoreController>( // For listning to pets changes
                builder: (controller) {
                  return
                  controller.pets.length == 0 ?
                   SizedBox(
                        height: Get.height * .59,
                        width: Get.width,
                        child: const Center(
                          child: Text('There is no pet found')
                        ),
                      ) :
                   ListView.builder(
                    itemCount: controller.pets.length,  
                    itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: 240,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.blueGrey[300],
                                  borderRadius: BorderRadius.circular(20),
                                    boxShadow: shadowList,
                                  ),
                                  margin: const EdgeInsets.only(top: 50),
                                ),
                                Align(
                                  //Hero animation
                                  child: Hero(
                                    //Using CachedNetworkImage to save images on local storage and to replace bad images url with static image
                                      tag:controller.pets[index].id,child: petStoreController.pets[index].photoUrls!.length == 0 ? Image.asset('assets/images/not_found1.png') : petStoreController.pets[index].photoUrls! == null ? Image.asset('assets/images/not_found1.png') : CachedNetworkImage(
                                      imageUrl: petStoreController.pets[index].photoUrls![0],
                                      fit: BoxFit.fill,
                                      placeholder: (context,url) => CircularProgressIndicator(),
                                      errorWidget: (context,url,error) => Image.asset('assets/images/not_found1.png', fit: BoxFit.fill, ),
                                    ),),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Get.height * .2,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(controller.pets[index].name, style: TextStyle(color: darkBgColor, fontSize: 14)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Category:', style: ThemeUtils.light.textTheme.subtitle1),
                                    Text(controller.pets[index].category?.name == null ? 'UnKown' : controller.pets[index].category!.name), 
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Status:', style: ThemeUtils.light.textTheme.subtitle1),
                                    Text(controller.pets[index].status, style: TextStyle(color: controller.pets[index].status == statusList[0] ? Colors.green[400] : controller.pets[index].status == statusList[1] ? Colors.orange[400] : Colors.red[400]),), 
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                    onPressed: ()  {
                                      Get.to(() => EditPetPage(index: index));
                                    }, child: const Icon(Icons.edit, color: Colors.black,)),
                                    ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                      onPressed: () => controller.deletePet(controller.pets[index].id), 
                                      child: const Icon(Icons.delete, color: Colors.red))
                                  ],
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(top: 60,bottom: 20),
                            decoration: BoxDecoration(color: Colors.white,
                            boxShadow: shadowList,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                              )
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                  });
                },
              )
            )
          ]),
      ),
      floatingActionButton: FloatingActionButton( //add pet botton
        onPressed: (() => Get.to(EditPetPage())),
        backgroundColor: ThemeUtils.light.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      )
    );
  }
}