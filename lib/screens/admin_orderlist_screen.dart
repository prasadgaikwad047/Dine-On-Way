import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/admin_menuedit_screen.dart';
import 'package:dine_on_way/screens/admin_orderview_screen.dart';
import 'package:dine_on_way/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../gen/colors.gen.dart';

class AdminOrderlistScreen extends StatefulWidget {
  AdminOrderlistScreen(
      {super.key, required this.indexno, required this.hoteldocument});
  CollectionReference referenceOrderList =
      FirebaseFirestore.instance.collection('order list');
  CollectionReference referenceHotelList =
      FirebaseFirestore.instance.collection('hotel list');
  CollectionReference referenceMenuList =
      FirebaseFirestore.instance.collection('menu list');
  int indexno;
  final QueryDocumentSnapshot hoteldocument;

  @override
  State<AdminOrderlistScreen> createState() => _AdminOrderlistScreenState();
}

class _AdminOrderlistScreenState extends State<AdminOrderlistScreen> {
  late Stream<QuerySnapshot> streamhotellist;
  late Stream<QuerySnapshot> streammenulist;
  late Stream<QuerySnapshot> streamorderlist;
  @override
  initState() {
    super.initState();
    streamhotellist = widget.referenceHotelList.snapshots();
    streammenulist = widget.referenceMenuList.snapshots();
    streamorderlist = widget.referenceOrderList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey.shade500,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Active orders',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900),
              ),
            ),
            elevation: 4,
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
                                indexno: widget.indexno,
                              )));
                },
              ),
            ]),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan.shade900,
                    shape: RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ), // EdgeInsets.symmetric
                  ),
                  onPressed: () {
                    Map<String, dynamic> getdata = {};
                  },
                  child: Text('Extra button'),
                ),
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: streamorderlist,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            {
              if (snapshot.connectionState == ConnectionState.active) {
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                    querySnapshot.docs;
                return Flexible(
                  child: ListView.builder(
                      itemCount: listQueryDocumentSnapshot.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot document =
                            listQueryDocumentSnapshot[index];
                        if (document['restaurantId'] ==
                            widget.hoteldocument['id']) {
                          return Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 2.5, bottom: 2.5),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2,
                                        color: Colors.blueGrey.shade700),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  tileColor: Colors.blueGrey.shade200,
                                  title: Text(
                                    document['name'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.blueGrey.shade900,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminOrderViewScreen(
                                                  indexno: widget.indexno,
                                                  documenthotel:
                                                      widget.hoteldocument,
                                                  orderdocument: document,
                                                )));
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('order list')
                                          .doc(document.id)
                                          .delete();
                                    },
                                  ),
                                ),
                              ),

                              /* Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12, left: 12, right: 12, top: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MenuEditScreen(
                                                      document: document,
                                                      indexno: widget.indexno,
                                                      //  menu: menu,
                                                    )));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                ColorName.yellow),
                                        elevation: MaterialStateProperty.all(0),
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(220, 50)),
                                      ),
                                      child: Text(
                                        'Add Item',
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade900),
                                      ),
                                    ), 
                                    
                                  ],
                                ),
                              ),*/
                            ],
                          );
                        } else {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      }),
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          },
        ));
  }
}
