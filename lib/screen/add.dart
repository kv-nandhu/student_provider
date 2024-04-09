// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studnet_provider/database/crud.dart';
import 'package:studnet_provider/database/model.dart';
import 'package:studnet_provider/database/validation.dart';
import 'package:studnet_provider/provider/helperclass.dart';
import 'package:studnet_provider/screen/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studnet_provider/widget/list.dart';
import 'package:studnet_provider/widget/textformfield.dart';

class DataInsert extends StatefulWidget {
  DataInsert({super.key, required this.isEdit, this.value});
  Studentupdates? value;
  bool isEdit = false;
  @override
  State<DataInsert> createState() => _DataInsertState();
}

class _DataInsertState extends State<DataInsert> {
  File? selectedImage;
  String? selectedweek;
  String? selectedhub;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Validations? val = Validations();
  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      nameController.text = widget.value!.name.toString();
      ageController.text = widget.value!.age.toString();
      phoneController.text = widget.value!.phone.toString();
      addressController.text = widget.value!.address.toString();
      selectedImage = File(widget.value!.image.toString());
      selectedhub = widget.value!.hub;
      selectedweek = widget.value!.week;
    }
    return Consumer<StudentProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: widget.isEdit
                ? Text("Data Edit", style: TextStyle(color: Colors.white))
                : Text("Data Entry", style: TextStyle(color: Colors.white)),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFields(
                    nameController: nameController,
                    ageController: ageController,
                    phoneController: phoneController,
                    addressController: addressController,),
                    Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          fillColor: Color(0xABFFFEFE),
          labelText: 'Seleect Hub',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        value: selectedhub,
        onChanged: (String? newvalue) {
          selectedhub = newvalue!;
        },
        items: CustomLists.hub.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          fillColor: Color(0xABFFFEFE),
          labelText: 'Select week',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        value: selectedweek,
        onChanged: (String? newValue) {
          selectedweek = newValue!;
        },
        items: CustomLists.week.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                          height: 200,
                          width: 200,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: Colors.deepOrange),
                          ),
                          child: selectedImage != null
                              ? Image.file(selectedImage!, fit: BoxFit.cover)
                              : Center(
                                  child: Text(
                                  'Image not selected',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ))),
                    ),
                    Column(children: [
                      IconButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedImage = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              selectedImage = File(pickedImage.path);
                              value.getimage(selectedImage!);
                            }
                          },
                          icon: Icon(Icons.photo)),
                      IconButton(onPressed: () async {
                              final picker = ImagePicker();
                            final pickedImage = await picker.pickImage(
                                source: ImageSource.camera);
                            if (pickedImage != null) {
                              selectedImage = File(pickedImage.path);
                              value.getimage(selectedImage!);
                            }
                      }, icon: Icon(Icons.camera))
                    ])
                  ]),
                  widget.isEdit == false
                      ? InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate() &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                addressController.text.isNotEmpty &&
                                ageController.text.isNotEmpty &&
                                selectedweek != null &&
                                selectedhub != null &&
                                selectedImage!.path.isNotEmpty) {
                              registerStudent(
                                context,
                                nameController.text.trim(),
                                selectedhub.toString(),
                                selectedweek.toString(),
                                int.parse(phoneController.text),
                                selectedImage!.path.toString(),
                                int.parse(ageController.text),
                                addressController.text,
                                _formKey,
                              );
                            } else {
                              nameController.clear();
                              phoneController.clear();
                              selectedImage =
                                  value.getimage(selectedImage = null);
                              selectedhub = null;
                              selectedweek = null;
                              showSnackBar(
                                  context, 'Register Failed!', Colors.red);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color:  Color.fromARGB(255, 66, 11, 11),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate() &&
                                nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                ageController.text.isNotEmpty &&
                                addressController.text.isNotEmpty &&
                                selectedhub != null &&
                                selectedweek != null &&
                                selectedImage!.path.isNotEmpty) {
                              editStudent(
                                  context,
                                  selectedImage,
                                  nameController.text,
                                  selectedhub.toString(),
                                  selectedweek.toString(),
                                  int.parse(phoneController.text.toString()),
                                  int.parse(ageController.text.toString()),
                                  addressController.text,
                                  int.parse(widget.value!.id.toString()));
                            } else {
                              nameController.clear();
                              phoneController.clear();
                              selectedImage =
                                  value.getimage(selectedImage = null);
                              // value.getimage(File(selectedImage.path.));
                              selectedweek = null;
                              selectedhub = null;
                              showSnackBar(
                                  context, 'Register Faild!', Colors.red);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 66, 11, 11),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(height: 50,)
          ])),
    );
  }
}
