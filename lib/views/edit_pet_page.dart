import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:petstore/controllers/pet_store.controller.dart';
import 'package:petstore/data/constants.dart';
import 'package:petstore/utils/them_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:petstore/utils/validator_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_tags/flutter_tags.dart';

class EditPetPage extends StatelessWidget {

  final index;
  EditPetPage({Key? key, this.index}) : super(key: key);
  final PetStoreController petStoreController = Get.find(); // find and generating an instance of petStoreController
  final CarouselController _carouselController = CarouselController();
  final _formKey = GlobalKey<FormState>(); //form key
  final _nameController = TextEditingController(); //name controller
  final _nameFocusNode = FocusNode();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    petStoreController.currentStatusValue.value = petStoreController.pets[index].status; //initialization of pet status
    _nameController.text = petStoreController.pets[index].name; //initialization of pet name formField
    print(petStoreController.pets[index].tags);
    return Scaffold(
      appBar: AppBar(
        title: Text(index == null ? 'Add Pet' : 'Edit Pet', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        leading: InkWell(
            child: const Icon(Icons.arrow_back, size: 28, color: Colors.black ,),
            onTap: () => Get.back(),
          ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blueGrey[300],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          )),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                  tag: petStoreController.pets[index].id,
                  child: CarouselSlider(
                    items: getImagesForCarousel(),
                    carouselController: _carouselController,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                      ),
                  ),
                ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 80,
              child:  Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < petStoreController.pets[index].tags!.length; i++)
                      Card(
                        color: ThemeUtils.light.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            petStoreController.pets[index].tags![i].name,
                            textScaleFactor: 1.2,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ),
                  ],
                )
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20)),

            ),
          ),
          Positioned(
            top: Get.height * .52,
            child: Container(
              height: Get.height * .18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 90,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        hintText: 'Put the new pet name',
                        hintStyle: TextStyle(fontSize: 13),
                        errorStyle: TextStyle(fontSize: 10),
                        filled: true,
                        isDense: true,
                      ),
                      validator: ValidatorUtils.nameValidator,
                      textInputAction: TextInputAction.next
                    ),
                    )
                  ),
                  Container(
                    height: 50,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton2( //We will use Obx stratment to listen to changes of currentStatusValue
          isDense: true,
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: statusList
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value:  petStoreController.currentStatusValue.value,
          onChanged: (value) {
              petStoreController.currentStatusValue.value = value as String;
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        )
        ),
      ),)
                ],
              )
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 80,
              child: Row(
                children: [
                  InkWell(
                    onTap: (() => Get.back()),
                    child: Container(
                    height: 60,
                    width: 70,
                    decoration: BoxDecoration(
                        color: ThemeUtils.light.primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.close,color: Colors.white,),
                  ),
                  ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // check if the pet name is not empty and valid then call to update function
                          if(_validateAndSave()) {
                            petStoreController.updatePet(petStoreController.pets[index].id, _nameController.text);
                            Get.back();
                          }
                        },
                        child: Container(
                        height: 60,
                        decoration: BoxDecoration(color: ThemeUtils.light.primaryColor ,borderRadius: BorderRadius.circular(20)),
                        child: const Center(child: Text('Save changes',style: TextStyle(color: Colors.white,fontSize: 24),)),
                      )),
                    )
                  ],
                ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), )
              ),
            ),
          )



        ],
      ),
    )
    );
  }
  List<Widget> getImagesForCarousel(){
    return petStoreController.pets[index].photoUrls!
    .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    //Image.network(item, fit: BoxFit.fill),
                    Container(
                      height: Get.height * .35,
                      child: CachedNetworkImage(
                        imageUrl: item,
                        fit: BoxFit.fill,
                        placeholder: (context,url) => CircularProgressIndicator(),
                        errorWidget: (context,url,error) => Image.asset('assets/images/not_found1.png', fit: BoxFit.fill, ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
    )
    .toList();
  }
  bool _validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}