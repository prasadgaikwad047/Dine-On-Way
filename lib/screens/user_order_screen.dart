import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/home_screen.dart';
import 'package:dine_on_way/screens/hotel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

class UserOrderScreen extends StatefulWidget {
  final QueryDocumentSnapshot documenthotel;
  final QueryDocumentSnapshot finaluserdoc;
  var orderlist = [];
  int totalbill;
  String name = 'Prasad Gaikwad';
  String location = '2:30 PM';

  // late Stream<QuerySnapshot> streammenulist;
  final QueryDocumentSnapshot menudoc;
  UserOrderScreen({
    super.key,
    required this.documenthotel,
    required this.menudoc,
    required this.orderlist,
    required this.totalbill,
    required this.finaluserdoc,
    // required this.streammenulist
  });

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  CollectionReference referenceMenuList =
      FirebaseFirestore.instance.collection('menu list');

  CollectionReference referenceOrderList =
      FirebaseFirestore.instance.collection('order list');

  late Stream<QuerySnapshot> streammenulist;
  late QueryDocumentSnapshot menudoc;

  String ordertype = "Dine In";
  bool ordertypetile = false;
  final List<int> noofpeoples = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int? totalpeople;

  @override
  initState() {
    super.initState();
    streammenulist = referenceMenuList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameTextController = TextEditingController();
    final TextEditingController locationTextController =
        TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Navigator.pop(context);
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
                  //  backgroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Colors.yellow.shade700,
                  shape: RoundedRectangleBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ), // EdgeInsets.symmetric
                ),
                onPressed: () async {
                  final newOrderDocRef = await referenceOrderList.add({
                    'restaurantName': widget.documenthotel['title'],
                    'restaurantId': widget.documenthotel['id'],
                    'route id': widget.documenthotel['routeId'],
                    'menulist': widget.orderlist,
                    'name': widget.name,
                    //'name': nameTextController.text,
                    'no of people': totalpeople,
                    'ordertype': ordertype,
                    'arrival': widget.location,
                    'number': widget.finaluserdoc['number'],
                    //'arrival': locationTextController.text,
                    'total amount': widget.totalbill,
                  });
                  final messagesCollectionRef =
                      newOrderDocRef.collection('messages');
                  final newMessageDocRef = await messagesCollectionRef.add({
                    'text':
                        "Thankyou for placing Order, Your Meal will be Ready when you reach us",
                    'sender': 'Admin',
                    'createdAt': Timestamp.now(),
                  });
                },
                child: Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Order list',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3)),
              // change to container
              height: 200,
              child: StreamBuilder<QuerySnapshot>(
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
                                        widget.documenthotel['id'] &&
                                    widget.orderlist.contains(menu.id)) {
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
                                                color: Colors.blueGrey.shade900,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic)),
                                        trailing: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "₹ ${menu['price']}/-",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
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
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15, right: 15, bottom: 7.5),
            child: TextFormField(
              onFieldSubmitted: (value) {
                setState(() {
                  widget.name = nameTextController.text;
                  print(widget.name);
                });
              },
              autofocus: true,
              controller: nameTextController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                hintText: widget.name,
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
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 7.5, bottom: 15.0, left: 15, right: 15),
            child: TextFormField(
              onFieldSubmitted: (value) {
                setState(() {
                  widget.location = locationTextController.text;
                  print(widget.location);
                });
              },
              autofocus: true,
              controller: locationTextController,
              decoration: InputDecoration(
                labelText: 'Arrival time or Live Location',
                hintText: widget.location,
                prefixIcon: Icon(
                  Icons.timelapse,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 16,
                      color: Colors.yellow.shade700,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'No of people',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow.shade700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: noofpeoples
                    .map((item) => DropdownMenuItem<int>(
                          value: item,
                          child: Text(
                            '${item}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow.shade800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: totalpeople,
                onChanged: (value) {
                  setState(() {
                    totalpeople = value as int;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: Colors.blueGrey.shade800, width: 2),
                    color: Colors.blueGrey.shade500,
                  ),
                  elevation: 2,
                ),
                iconStyleData: IconStyleData(
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.yellow.shade700,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  padding: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.blueGrey.shade600,
                  ),
                  elevation: 8,
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 10),
            child: SwitchListTile(
              tileColor: Colors.blueGrey.shade300,
              activeColor: Colors.blueGrey.shade800,
              shape: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Colors.blueGrey.shade900),
              title: Text(
                'Select for Take Away',
                style: TextStyle(
                    color: Colors.blueGrey.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              value: ordertypetile,
              dense: false,
              onChanged: (bool value) {
                setState(() {
                  ordertypetile = value;
                  if (ordertypetile) {
                    ordertype = 'Take away';
                  } else {
                    ordertype = 'Dine In';
                  }
                  print(ordertype);
                });
              },
              secondary: Icon(
                Icons.food_bank_sharp,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Get your food served moment You arrive...",
              style: TextStyle(
                  color: Colors.blueGrey.shade800,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 25, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total bill",
                  style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontSize: 23,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  " ₹ ${widget.totalbill}/-",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.blueGrey.shade900,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
