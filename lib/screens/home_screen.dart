import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/gen/assets.gen.dart';
import 'package:dine_on_way/gen/colors.gen.dart';
import 'package:dine_on_way/gen/fonts.gen.dart';
import 'package:dine_on_way/models/menuitem_model.dart';
import 'package:dine_on_way/screens/hotel_screen.dart';
import 'package:dine_on_way/screens/landing_page.dart';
import 'package:dine_on_way/screens/map_screen.dart';
import 'package:dine_on_way/screens/user_orderview_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:dine_on_way/models/hotel_model.dart';

import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  final QueryDocumentSnapshot finaluserdoc;
  HomeScreen({super.key, required this.finaluserdoc});
  var globalrouteId = 1;
  String from = '';
  String to = '';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference referenceHotelList =
      FirebaseFirestore.instance.collection('hotel list');

  late Stream<QuerySnapshot> streamhotellist;
  final TextEditingController fromTextController = TextEditingController();

  final TextEditingController toTextController = TextEditingController();

  @override
  initState() {
    super.initState();
    streamhotellist = referenceHotelList.snapshots();
    widget.globalrouteId = 1;
  }

  @override
  Widget build(BuildContext context) {
    final dateTextController = TextEditingController();

    dateTextController.text = DateFormat('dd MMM yyyy').format(DateTime.now());
    //  referenceHotelList.snapshots();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(199, 28, 142, 152),
      bottomNavigationBar: CustomNavBar(
        index: 0,
        finaluserdoc: widget.finaluserdoc,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.25),
              color: Color.fromARGB(234, 255, 255, 255),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _HeaderSection(
                    finaluserdoc: widget.finaluserdoc,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: ColorName.lightGrey.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Color.fromARGB(255, 5, 61, 107),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: TextField(
                                controller: dateTextController,
                                decoration: const InputDecoration(
                                    label: Text(
                                      'Select Date',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 5, 61, 107)),
                                    ),
                                    border: InputBorder.none),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  //color: Color.fromARGB(255, 5, 61, 107)
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color.fromARGB(255, 5, 61, 107),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    widget.from = fromTextController.text;
                                    //  print(widget.from);
                                  });
                                },
                                controller: fromTextController,
                                decoration: const InputDecoration(
                                    hintText: "Mumbai",
                                    label: Text(
                                      'From',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 5, 61, 107)),
                                    ),
                                    border: InputBorder.none),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(),
                            Flexible(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    widget.to = toTextController.text;
                                    // print(widget.to);
                                  });
                                },
                                controller: toTextController,
                                decoration: const InputDecoration(
                                    hintText: "Pune",
                                    label: Text(
                                      'To',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 5, 61, 107)),
                                    ),
                                    border: InputBorder.none),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            //  print(widget.from);
                            // print(widget.to);
                            if (widget.from == 'goa' || widget.to == 'goa') {
                              setState(() {
                                widget.globalrouteId = 2;
                              });
                            } else if (widget.from == 'pune' ||
                                widget.to == 'pune') {
                              setState(() {
                                widget.globalrouteId = 1;
                              });
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStateProperty.all(ColorName.yellow),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize:
                                MaterialStateProperty.all(const Size(220, 50)),
                          ),
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.blueGrey.shade900),
                          ),
                        )
                      ],
                    ),
                  ),
                  //  _SearchCard(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 364,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: streamhotellist,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            QuerySnapshot querySnapshot = snapshot.data;
                            List<QueryDocumentSnapshot>
                                listQueryDocumentSnapshot = querySnapshot.docs;
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: listQueryDocumentSnapshot.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    QueryDocumentSnapshot document =
                                        listQueryDocumentSnapshot[index];

                                    if (document['routeId'] ==
                                        widget.globalrouteId) {
                                      print(widget.globalrouteId);
                                      return _HotelCard(
                                        finaluserdoc: widget.finaluserdoc,
                                        document: document,
                                        indexno: index,
                                        listQueryDocumentSnapshot:
                                            listQueryDocumentSnapshot,
                                      );
                                    } else {
                                      return SizedBox(
                                        height: 0,
                                      );
                                    }
                                  }),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                      },
                    ),
                  ),
                  /* _NearByHotels(
                    finaluserdoc: widget.finaluserdoc,
                    streamhotellist: streamhotellist,
                  ), */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final QueryDocumentSnapshot finaluserdoc;
  const _HeaderSection({super.key, required this.finaluserdoc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: Assets.image.img1.provider(),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LandingPage()));
                },
                icon: const Icon(Icons.logout_sharp),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Welcome Back ${finaluserdoc['name']}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final QueryDocumentSnapshot finaluserdoc;
  const CustomNavBar(
      {required this.index, super.key, required this.finaluserdoc});
  final int index;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Color.fromARGB(234, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarIcon(
              iconPath: Assets.icon.amenities.home,
              isSelected: index == 0,
              text: 'Home',
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              finaluserdoc: finaluserdoc,
                            )));
              },
            ),
            _NavBarIcon(
              iconPath: Assets.icon.amenities.map,
              isSelected: index == 1,
              text: 'Map',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapScreen(
                            finaluserdoc: finaluserdoc,
                          )),
                );
                /* Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MapScreen())); */
              },
            ),
            _NavBarIcon(
              iconPath: Assets.icon.amenities.booking,
              isSelected: index == 2,
              text: 'Order',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserOrderViewScreen(
                            usernumber: finaluserdoc['number'])));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  const _NavBarIcon({
    Key? key,
    required this.iconPath,
    required this.text,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);
  final String iconPath;
  final String text;
  final Function()? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final color = isSelected ? ColorName.primaryColor : ColorName.lightGrey;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath, color: color),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: FontFamily.schyler,
              fontWeight: FontWeight.w600,
              color: color,
            ), // TextStyle
          ), // Text
        ],
      ), // Column
    );
  }
} // InkWell

class _HotelCard extends StatelessWidget {
  final List<QueryDocumentSnapshot> listQueryDocumentSnapshot;
  final QueryDocumentSnapshot document;
  final QueryDocumentSnapshot finaluserdoc;
  var indexno;
  _HotelCard(
      {super.key,
      required this.listQueryDocumentSnapshot,
      required this.document,
      required this.finaluserdoc,
      required this.indexno});
  // final HotelModel hotel;
// QueryDocumentSnapshot document = listQueryDocumentSnapshot[index];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HotelScreen(
                      document: listQueryDocumentSnapshot[indexno],
                      finaluserdoc: finaluserdoc,
                      index: indexno,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(227, 148, 148, 172).withAlpha(50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    child: Image.network(document['thumbnailPath']))),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Text(
                        document['title'],
                        style: TextStyle(
                            fontSize: 18, color: Colors.blueGrey.shade900),
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
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomRating(
                        document: document,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CustomRating extends StatelessWidget {
  QueryDocumentSnapshot document;
  //final double ratingScore;
  final int totalReviews;
  final bool showReviews;
  CustomRating({
    required this.document,
    //  required this.ratingScore,
    this.totalReviews = 0,
    this.showReviews = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const size = 15.0;
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Container(
            margin: const EdgeInsets.all(1.0),
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: i <= document['ratingScore']
                  ? ColorName.yellow
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorName.yellow,
                width: 2.0,
              ), // Border.all
            ), // BoxDecoration
          ), // Container
        const SizedBox(width: 10),
        Text(
          "${document['ratingScore']}",
          style: const TextStyle(fontSize: 11),
        ),
// TODO: Show
      ],
    ); // Row
  }
}
