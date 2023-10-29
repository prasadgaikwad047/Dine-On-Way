import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/models/hotel_model.dart';
import 'package:dine_on_way/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../gen/colors.gen.dart';

class AdminVerification extends StatefulWidget {
  const AdminVerification({super.key});

  @override
  State<AdminVerification> createState() => _AdminVerificationState();
}

class _AdminVerificationState extends State<AdminVerification> {
  CollectionReference referenceHotelList =
      FirebaseFirestore.instance.collection('hotel list');

  late Stream<QuerySnapshot> streamhotellist;
  late List<QueryDocumentSnapshot> listQueryDocumentSnapshot;

  @override
  initState() {
    super.initState();
    streamhotellist = referenceHotelList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final String id;
    final idController = TextEditingController();
    final idList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      labelText: 'Enter Unique Id no',
                      labelStyle: TextStyle(
                        color: Colors.grey[700],
                        // fontWeight: FontWeight.bold,
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade900),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  var no = int.parse(idController.text);
                  if (idList[no] != null) {
                    List<HotelModel> h1 = HotelModel.sampleHotels
                        .where((unit) => unit.id == no)
                        .toList();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainAdminScreen(
                                  indexno: no,
                                )));
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(ColorName.yellow),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(color: Colors.blueGrey.shade900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
