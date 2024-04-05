import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studnet_provider/database/function.dart';
import 'package:studnet_provider/database/model.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

Future<void> registerStudent(
  BuildContext context,
  String name,
  String hub,
  String week,
  int phone,
  String image,
  int age,
  String address,
  GlobalKey<FormState> formKey) async {
    if(image.isEmpty) {
      return;
    }
      if (formKey.currentState!.validate() &&
      name.isNotEmpty &&
      hub.isNotEmpty &&
      week.isNotEmpty &&
      age != null &&
      address.isNotEmpty &&
      phone != null) {
    final add = Studentupdates(
        week: week,
        address: address,
        image: image,
        name: name,
        phone: phone,
        hub: hub,
        age: age,
        id: -1);
    addStudent(add);
    showSnackBar(context, 'Register Successful', Colors.green);
    Navigator.pop(context);
  }
  }
  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
    duration: Duration(seconds: 2),
    backgroundColor: color,));
  }

  Future<void> editStudent(context, File? image, String name,String hub,String week,
  int phone, int age, String address,int id) async {
    final editbox = await Hive.openBox<Studentupdates>('student');
    final existingStudent = editbox.values.firstWhere((element) => element.id == id);
    if(existingStudent != null) {
      existingStudent.name = name;
      existingStudent.age = age;
      existingStudent.phone = phone;
      existingStudent.address = address;
      existingStudent.week = week;
      existingStudent.hub = hub;
      existingStudent.image = image!.path;

      await editbox.put(id, existingStudent);
      getStudent();
      Navigator.pop(context);
    }
  }

  void delete(BuildContext context,int? id) {
    showDialog(context: context,
     builder: (context){
      return AlertDialog(
        title: Text('delete'),
        content: Text('remove the developer'),
        actions: [
          ElevatedButton(onPressed: () {
            dlt(context, id);
          }, child: Text('Yes')),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('No'))
        ],
      );
     });
  }

  Future<void> dlt(context, int? id) async {
    final remove = await Hive.openBox<Studentupdates>('student');
    remove.delete(id);
    getStudent();
    showSnackBar(context, 'Delete', Colors.red);
    Navigator.pop(context);
  }