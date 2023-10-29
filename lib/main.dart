import 'package:dine_on_way/screens/admin_verification_screen.dart';
import 'package:dine_on_way/screens/chat_screen.dart';
import 'package:dine_on_way/screens/home_screen.dart';
import 'package:dine_on_way/screens/landing_page.dart';
import 'package:dine_on_way/screens/map_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:dine_on_way/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomeScreen(),
      //home: ChatScreen(),

      // home: LandingPage(),
      home: splashScreen(),
    );
  }
}


/* 

 Text(
                "Customer name : ${widget.orderdocument['name']}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.5,
                    wordSpacing: 3.0,
                    fontFamily: 'Helvetica'),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: Text(
                  "Arrival : ${widget.orderdocument['arrival']} ",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.5,
                      wordSpacing: 3.0,
                      fontFamily: 'Helvetica'),
                ),
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: widget.orderdocument['arrival']));
                },
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "No of people : ${widget.orderdocument['no of people']}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.5,
                    wordSpacing: 3.0,
                    fontFamily: 'Helvetica'),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Order type : ${widget.orderdocument['ordertype']}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.5,
                    wordSpacing: 3.0,
                    fontFamily: 'Helvetica'),
              ),
              const SizedBox(
                height: 12,
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
                height: 10,
              ),
/////
Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onFieldSubmitted: (value) {
                setState(() {
                  usernumber = usernumberTextController.text;
                  getData();
                  print(usernumber);
                });
              },
              autofocus: true,
              controller: usernumberTextController,
              decoration: InputDecoration(
                labelText: 'Enter your number',
                // hintText: widget.name,
                prefixIcon: Icon(
                  Icons.person,
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
            Padding(
              padding: const EdgeInsets.only(left: 67),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                finaluserdoc: finaluserdoc,
                              )));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(ColorName.yellow),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(const Size(220, 50)),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.blueGrey.shade900),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 67),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminVerification()));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(ColorName.yellow),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(const Size(220, 50)),
                ),
                child: Text(
                  'Admin',
                  style: TextStyle(color: Colors.blueGrey.shade900),
                ),
              ),
            ),
          ],
        ),
      ), */


      /* class _SearchCard extends StatefulWidget {
  _SearchCard({super.key});
  String from = '';
  String to = '';
  @override
  State<_SearchCard> createState() => _SearchCardState();
} */

/* class _SearchCardState extends State<_SearchCard> {
  @override
  Widget build(BuildContext context) {
    @override
    final TextEditingController fromTextController = TextEditingController();

    final TextEditingController toTextController = TextEditingController();

    final dateTextController = TextEditingController();

    dateTextController.text = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorName.lightGrey.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: TextField(
                  controller: dateTextController,
                  decoration: InputDecoration(
                      label: const Text(
                        'Select Date',
                        style: TextStyle(color: Colors.blue),
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      widget.from = fromTextController.text;
                      print(widget.from);
                    });
                  },
                  controller: fromTextController,
                  decoration: InputDecoration(
                      label: const Text(
                        'From',
                        style: TextStyle(color: Colors.blue),
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              Flexible(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      widget.to = toTextController.text;
                    });
                  },
                  controller: toTextController,
                  decoration: InputDecoration(
                      label: const Text(
                        'To',
                        style: TextStyle(color: Colors.blue),
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              print(widget.from);
              print(widget.to);
              if (widget.from == 'goa' || widget.to == 'goa') {
                setState(() {
                  globalrouteId = 2;
                });
              } else {
                setState(() {
                  globalrouteId = 1;
                });
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(ColorName.yellow),
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size(220, 50)),
            ),
            child: Text(
              'Search',
              style: TextStyle(color: Colors.blueGrey.shade900),
            ),
          )
        ],
      ),
    );
  }
} */


/* class _NearByHotels extends StatelessWidget {
  final QueryDocumentSnapshot finaluserdoc;
  late Stream<QuerySnapshot> streamhotellist;
  _NearByHotels({
    super.key,
    required this.finaluserdoc,
    required this.streamhotellist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hotels on way',
          style: TextStyle(
              color: ColorName.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        /*  ListView.builder(
            itemCount: HotelModel.sampleHotels.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _HotelCard(
                hotel: HotelModel.sampleHotels[index],
              );
            })  */
        SizedBox(
          height: 2,
        ),
        Container(
          height: 364,
          child: StreamBuilder<QuerySnapshot>(
            stream: streamhotellist,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              {
                if (snapshot.connectionState == ConnectionState.active) {
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                      querySnapshot.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: listQueryDocumentSnapshot.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot document =
                              listQueryDocumentSnapshot[index];
                          if (document['routeId'] == globalrouteId) {
                            return _HotelCard(
                              finaluserdoc: finaluserdoc,
                              document: document,
                              indexno: index,
                              listQueryDocumentSnapshot:
                                  listQueryDocumentSnapshot,
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
      ],
    );
  }
} */