import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/models/hotel_model.dart';
import 'package:dine_on_way/models/menuitem_model.dart';
import 'package:dine_on_way/screens/home_screen.dart';
import 'package:dine_on_way/screens/user_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../gen/colors.gen.dart';

class HotelScreen extends StatefulWidget {
  final QueryDocumentSnapshot document;
  final QueryDocumentSnapshot finaluserdoc;

  final index;
  HotelScreen({
    super.key,
    required this.document,
    required this.finaluserdoc,
    required this.index,
  });

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  CollectionReference referenceMenuList =
      FirebaseFirestore.instance.collection('menu list');

  late Stream<QuerySnapshot> streammenulist;
  late QueryDocumentSnapshot menudoc;
  var orderlist = [];
  int totalbill = 0;

  @override
  initState() {
    super.initState();
    streammenulist = referenceMenuList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                        builder: (context) =>
                            HomeScreen(finaluserdoc: widget.finaluserdoc)));
              },
            ),
          ]),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //  backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Colors.yellow.shade700,
                shape: RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ), // EdgeInsets.symmetric
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserOrderScreen(
                              documenthotel: widget.document,
                              orderlist: orderlist,
                              totalbill: totalbill,
                              //    streammenulist: streammenulist,
                              menudoc: menudoc,
                              finaluserdoc: widget.finaluserdoc,
                            )),
                  );
                });

                /*    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserOrderScreen(
                              documenthotel: widget.document,
                              menudoc: menudoc,
                            ))); */
              },
              child: Text('Order Food'),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Expanded(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(145, 10, 87, 87),
                Color.fromARGB(207, 255, 255, 255)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Color.fromARGB(199, 28, 142, 152),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 50),
                  ), // BorderRadiễs.vertical
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.document['thumbnailPath'],
                      ) // NetworkImage
                      ), // Decoration Image
                ), // BoxDecoration
              ), // Container

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.document['title'],
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
                            widget.document['address'],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRating(
                        document: widget.document,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          enableInfiniteScroll: false,
                        ),
                        items: widget.document['imagePaths']
                            .map<Widget>((hotel) => ImageSlider(hotel: hotel))
                            .toList(),
                      ),
                      // ImageSlider(),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Menu',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade600),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: streammenulist,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    {
                      if (snapshot.connectionState == ConnectionState.active) {
                        QuerySnapshot querySnapshot = snapshot.data;
                        List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                            querySnapshot.docs;
                        return Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: listQueryDocumentSnapshot.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot menu =
                                    listQueryDocumentSnapshot[index];
                                if (menu['restaurantId'] ==
                                    widget.document['id']) {
                                  menudoc = menu;
                                  return Container(
                                    height: 40,
                                    // color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ListTile(
                                        //tileColor: Colors.blueGrey.shade100,
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(menu['name'],
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400)),
                                        trailing: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "₹ ${menu['price']}/-",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            /*  IconButton(
                                                  icon: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.blueGrey,
                                                  ),
                                                  onPressed: () {},
                                                )  */
                                            GestureDetector(
                                              child:
                                                  (!orderlist.contains(menu.id))
                                                      ? Icon(
                                                          Icons.add_circle,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        ),
                                              onTap: () {
                                                setState(() {
                                                  if (orderlist
                                                      .contains(menu.id)) {
                                                    orderlist.remove(menu.id);
                                                    totalbill = totalbill -
                                                        menu['price'] as int;
                                                  } else {
                                                    orderlist.add(menu.id);
                                                    totalbill = totalbill +
                                                        menu['price'] as int;
                                                  }
                                                  // print(orderlist);
                                                });
                                              },
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
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  final String hotel;

  const ImageSlider({required this.hotel, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Stack(
          children: <Widget>[
            Image.network(
              hotel,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
            //  Image.asset(hotel, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key, // required this.hotel, //required this.indexno,
      required this.menu});
  // final HotelModel hotel;
  // final int indexno;
  final QueryDocumentSnapshot menu;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: ColorName.lightGrey.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        Text(menu['name']),
        const SizedBox(
          width: 10,
        ),
        Text("${menu['price']}"),
      ]),
    );
  }
}
