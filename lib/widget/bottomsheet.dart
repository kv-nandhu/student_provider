// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studnet_provider/widget/color.dart';


void bottomSheet(context, String name, String hub, String week, int phone, int age,String address,
    String image) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext builder) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 55, 61, 66),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          height: 1000,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(File(image)),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                name.toUpperCase(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CustomColor.getColor(),),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('hub : $hub',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400,color: CustomColor.getColor(),))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('week : $week',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400,color: CustomColor.getColor(),))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('phone : $phone',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400,color: CustomColor.getColor(),))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('age : $age',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400,color: CustomColor.getColor(),))),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('address : $address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400,color: CustomColor.getColor(),))),
              ),
            ],
          ),
        );
      });
}