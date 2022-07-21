import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore/controllers/pet_store.controller.dart';

class UpdatePetDialog extends StatefulWidget {
  final Function submit;
  final Function Cancel;

  const UpdatePetDialog(
      {Key? key, required this.submit, required this.Cancel})
      : super(key: key);

  @override
  _UpdatePetDialogState createState() => _UpdatePetDialogState();
}
class _UpdatePetDialogState extends State<UpdatePetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}