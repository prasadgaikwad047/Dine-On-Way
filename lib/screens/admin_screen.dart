import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/models/hotel_model.dart';
import 'package:dine_on_way/screens/admin_menuedit_screen.dart';
import 'package:dine_on_way/screens/admin_orderlist_screen.dart';
import 'package:dine_on_way/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../gen/colors.gen.dart';

class MainAdminScreen extends StatefulWidget {
  MainAdminScreen({super.key, required this.indexno});
  int indexno;
  CollectionReference referenceHotelList =
      FirebaseFirestore.instance.collection('hotel list');
  CollectionReference referenceMenuList =
      FirebaseFirestore.instance.collection('menu list');

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  late Stream<QuerySnapshot> streamhotellist;
  late Stream<QuerySnapshot> streammenulist;
  late QueryDocumentSnapshot hoteldocument;

  @override
  initState() {
    super.initState();
    streamhotellist = widget.referenceHotelList.snapshots();
    streammenulist = widget.referenceMenuList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LandingPage()));
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminOrderlistScreen(
                                  indexno: widget.indexno,
                                  hoteldocument: hoteldocument,
                                )));
                  },
                  child: Text('Order List'),
                ),
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: streamhotellist,
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
                        if (document['id'] == widget.indexno) {
                          hoteldocument = document;

                          return Column(
                            children: <Widget>[
                              Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.elliptical(
                                        MediaQuery.of(context).size.width, 50),
                                  ), // BorderRadiễs.vertical
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        document['thumbnailPath'],
                                      ) // NetworkImage
                                      ), // Decoration Image
                                ), // BoxDecoration
                              ), // Container
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                document['title'],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blueGrey.shade900,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    document['address'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Manage your Menu',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey.shade600),
                                ),
                              ),

                              StreamBuilder<QuerySnapshot>(
                                  stream: streammenulist,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    {
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        QuerySnapshot querySnapshot =
                                            snapshot.data;
                                        List<QueryDocumentSnapshot>
                                            listQueryDocumentSnapshot =
                                            querySnapshot.docs;
                                        return SizedBox(
                                          height: 260,
                                          child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  listQueryDocumentSnapshot
                                                      .length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                QueryDocumentSnapshot menu =
                                                    listQueryDocumentSnapshot[
                                                        index];
                                                if (menu['restaurantId'] ==
                                                    document['id']) {
                                                  return Container(
                                                    height: 40,
                                                    // color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: ListTile(
                                                        dense: true,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: Text(
                                                            menu['name'],
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        trailing: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "₹ ${menu['price']}/-",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Colors
                                                                    .blueGrey,
                                                              ),
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'menu list')
                                                                    .doc(
                                                                        menu.id)
                                                                    .delete();
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
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
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  }),
                              Padding(
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
                                    /*  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        shape: RoundedRectangleBorder(),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 50,
                                        ), // EdgeInsets.symmetric
                                      ),
                                      onPressed: () {
                                        Map<String, dynamic> getdata = {};
                                      },
                                      child: Text('Delete Item'),
                                    ), */
                                  ],
                                ),
                              ),
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
