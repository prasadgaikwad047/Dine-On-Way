import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/admin_orderlist_screen.dart';
import 'package:dine_on_way/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/services.dart';

import '../gen/colors.gen.dart';

class UserOrderViewScreen extends StatefulWidget {
  final usernumber;
  const UserOrderViewScreen({super.key, required this.usernumber});

  @override
  State<UserOrderViewScreen> createState() => _UserOrderViewScreenState();
}

class _UserOrderViewScreenState extends State<UserOrderViewScreen> {
  CollectionReference referenceOrderList =
      FirebaseFirestore.instance.collection('order list');
  CollectionReference referenceMenuList =
      FirebaseFirestore.instance.collection('menu list');
  late Stream<QuerySnapshot> streammenulist;
  late QueryDocumentSnapshot finalorderdoc;
  var orderlist = [];
  var flag = 0;
  getData() async {
    await for (var snapshot in referenceOrderList.snapshots()) {
      for (var document in snapshot.docs) {
        //print(document.data()); //You'll get printed the whole data
        if (document['number'] == widget.usernumber) {
          setState(() {
            finalorderdoc = document;
            flag = 1;
            //  print(finaluserdoc['name']);
          });
        } else {
          //user not found
        }
      }
    }
  }

  @override
  initState() {
    super.initState();
    streammenulist = referenceMenuList.snapshots();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (flag == 1) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(138, 20, 76, 81),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Order Details',
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
                    Navigator.pop(context);
                  },
                ),
              ]),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 100, left: 20, right: 20, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Restaurant   : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                      Text(
                        "${finalorderdoc['restaurantName']}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Guest name : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                      Text(
                        " ${finalorderdoc['name']}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Text(
                          "Arrival          : ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1.5,
                              wordSpacing: 3.0,
                              fontFamily: 'Helvetica'),
                        ),
                        Text(
                          "${finalorderdoc['arrival']}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1.5,
                              wordSpacing: 3.0,
                              fontFamily: 'Helvetica'),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: finalorderdoc['arrival']));
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Total seats   : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                      Text(
                        "${finalorderdoc['no of people']}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Order type    : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                      Text(
                        "${finalorderdoc['ordertype']}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1.5,
                            wordSpacing: 3.0,
                            fontFamily: 'Helvetica'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 78),
                    child: Text(
                      "Ordered Menu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1.5,
                          wordSpacing: 3.0,
                          fontFamily: 'Helvetica'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3)),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: streammenulist,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                QuerySnapshot querySnapshot = snapshot.data;
                                List<QueryDocumentSnapshot>
                                    listQueryDocumentSnapshot =
                                    querySnapshot.docs;
                                return Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          listQueryDocumentSnapshot.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        QueryDocumentSnapshot menu =
                                            listQueryDocumentSnapshot[index];
                                        orderlist = finalorderdoc['menulist'];
                                        if (orderlist.contains(menu.id)) {
                                          print(menu.id);
                                          print(menu['name']);
                                          /*  widget.totalbill =
                                            widget.totalbill + menu['price'] as int;
                                        print(widget.totalbill); */

                                          return Container(
                                            height: 40,
                                            // color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 20,
                                                  right: 20),
                                              child: ListTile(
                                                tileColor: Colors.transparent,
                                                dense: true,
                                                contentPadding: EdgeInsets.zero,
                                                title: Text(menu['name'],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey.shade900,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                                trailing: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "₹ ${menu['price']}/-",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
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
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 55.0, right: 55, top: 20, bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    finalorderdoc: finalorderdoc,
                                    user: 'customer',
                                  )),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(ColorName.yellow),
                        elevation: MaterialStateProperty.all(0),
                        minimumSize:
                            MaterialStateProperty.all(const Size(220, 50)),
                      ),
                      child: Text(
                        'Message',
                        style: TextStyle(color: Colors.blueGrey.shade900),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27),
                    child: Text(
                      "Total order amount: ₹${finalorderdoc['total amount']}/-",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1.5,
                          wordSpacing: 3.0,
                          fontFamily: 'Helvetica'),
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey.shade500,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Order Details',
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
                  Navigator.pop(context);
                },
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'No active orders, Place One',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900),
          ),
        ),
      );
    }
  }
}
