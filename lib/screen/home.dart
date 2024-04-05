import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animated_appbar/animated_appbar.dart';
import 'package:studnet_provider/database/crud.dart';
import 'package:studnet_provider/database/function.dart';
import 'package:studnet_provider/database/model.dart';
import 'package:studnet_provider/provider/helperclass.dart';
import 'package:studnet_provider/screen/add.dart';
import 'package:studnet_provider/widget/appbar.dart';
import 'package:provider/provider.dart';
import 'package:studnet_provider/widget/bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getStudent();
    super.initState();
    searchControler.removeListener(() {
      searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Consumer<StudentProvider>(builder: (context, value, child) {
      
      return Scaffold(
        appBar: appbar(context, value),
        body: ValueListenableBuilder(
            valueListenable: studentlist,
            builder: (context, List<Studentupdates> students, Widget? child) {
              return studentlist.value.isEmpty
                  ? Expanded(
                      child: Container(
                        // height: 600,
                        //width: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Image.asset(
                                "images/error.png",
                                height: 200,
                              ),
                             
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: students.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        mainAxisExtent: 305,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final studentdata = students.reversed.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              bottomSheet(
                                  context,
                                  studentdata.name!,
                                  studentdata.hub!,
                                  studentdata.week!,
                                  studentdata.phone!,
                                  studentdata.age!,
                                  studentdata.address!,
                                  studentdata.image!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Color.fromARGB(255, 236, 228, 233),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: Container(
                                        color: Colors.grey,
                                        child: Placeholder(
                                          child: Image.file(
                                            File(studentdata.image!),
                                            height: 170,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            studentdata.name!.toUpperCase(),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            studentdata.hub!.toUpperCase(),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (reg) =>
                                                              DataInsert(
                                                                isEdit: true,
                                                                value:
                                                                    studentdata,
                                                              )));
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  delete(
                                                      context, studentdata.id);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ));
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 66, 11, 11),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (reg) => DataInsert(
                        isEdit: false,
                      )),
            );
          },
        ),
      );
    });
  }
}
