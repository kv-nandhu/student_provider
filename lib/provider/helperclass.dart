import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studnet_provider/database/model.dart';

class StudentProvider extends ChangeNotifier {
  File? selectedimage;
  String? onsearch;
  List<Studentupdates> _studentlist = [];
  List<Studentupdates> get studentsearchlist => _studentlist;

  getimage(File? image) {
    selectedimage = image;
    notifyListeners();
  }

  getsearchtext(String? str) {
    onsearch = str;
    notifyListeners();
  }
  searchStudent(List<Studentupdates> newlist) {
   _studentlist = newlist;
  }
}