import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studnet_provider/database/function.dart';
import 'package:studnet_provider/database/model.dart';
import 'package:hive/hive.dart';

final searchControler = TextEditingController();
Timer? debouncer;

String searchText = '';
AppBar appbar(BuildContext context,value) {
  return AppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            bottom:
                Radius.elliptical(MediaQuery.of(context).size.width, 70.0))),
    title: Row(
      children: [
        Row(
          children: [
            Image.asset(
              "images/flutter.png",
              height: 50,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Flutter',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 142, 221),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ₿OX',
                        style: TextStyle(
                          color: Color.fromARGB(255, 235, 231, 231),
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'F L U T T E R    D E VE L O P E R',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 247, 247),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: SizedBox(
        height: 80,
        child: Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              onChanged: (values) {
                value.getsearchtext(values);
                onSearchChange(values);
              },
              controller: searchControler,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                hintText: 'Enthita myre nokkane...❔',
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                    onPressed: () {
                      searchControler.clear();
                      value.getsearchText('');
                      getStudent();
                    },
                    icon: Icon(Icons.close)),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void  onSearchChange(String values) {
  final studentdb = Hive.box<Studentupdates>('student');
  final students = studentdb.values.toList();
  values = searchControler.text;
  if (debouncer?.isActive ?? false) debouncer?.cancel();
  debouncer = Timer(Duration(milliseconds: 200), () {
    if (searchText != searchControler) {
      final filterdStudent = students
          .where((students) => students.name!
              .toLowerCase()
              .trim()
              .contains(values.toLowerCase().trim()))
          .toList();
      studentlist.value = filterdStudent;
    }
  });
}
