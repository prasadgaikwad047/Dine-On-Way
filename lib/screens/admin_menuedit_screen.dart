import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/admin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../gen/colors.gen.dart';

class MenuEditScreen extends StatelessWidget {
  MenuEditScreen(
      {super.key,
      required this.document,
      required this.indexno //required this.menu
      });
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('menu list');
  final QueryDocumentSnapshot document;
  int indexno;

  // final QueryDocumentSnapshot menu;
  @override
  Widget build(BuildContext context) {
    final itemTextController = TextEditingController();
    final priceTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainAdminScreen(
                              indexno: indexno,
                            )));
              },
            ),
          ]),
      body: Column(
        children: [
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 10, bottom: 6),
              child: TextField(
                controller: itemTextController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(
                    Icons.local_restaurant_outlined,
                    color: Colors.blueGrey.shade500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade600, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 10, bottom: 6),
              child: TextField(
                controller: priceTextController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.blueGrey.shade500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade600, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              /*   Map<String, dynamic> dataToSave = {
                'id': 10,
                'name': itemTextController.text,
                'price': priceTextController,
                'restaurantId': document['id'],
              }; */

              await collectionRef.add({
                'id': 10,
                'name': itemTextController.text,
                'price': int.parse(priceTextController.text),
                'restaurantId': document['id'],
              }).then((value) => print('user added'));
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(ColorName.yellow),
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size(220, 50)),
            ),
            child: Text(
              'Add Item',
              style: TextStyle(color: Colors.blueGrey.shade900),
            ),
          )
        ],
      ),
    );
  }
}
