import 'package:petstore/views/edit_pet_page.dart';
import 'package:petstore/views/pets_store_page.dart';

class Routes {

  var routes = {
    '/': (context) => PetsStorePage(),
    'edit': (context) => EditPetPage(),
  };

}