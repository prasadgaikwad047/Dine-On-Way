import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/admin_verification_screen.dart';
import 'package:dine_on_way/screens/home_screen.dart';
import 'package:dine_on_way/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../gen/colors.gen.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});
  var gotdata = 0;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final userRef = FirebaseFirestore.instance.collection('user list');
  late Stream<QuerySnapshot> userlist;
  static String usernumber = '';
  late QueryDocumentSnapshot finaluserdoc;

  final TextEditingController usernumberTextController =
      TextEditingController();

  getData() async {
    final querySnapshot = await userRef.get();
    for (final docSnapshot in querySnapshot.docs) {
      print(docSnapshot['number']);
      if (docSnapshot['number'] == usernumber) {
        setState(() {
          finaluserdoc = docSnapshot;
          widget.gotdata = 1;
          //  print(finaluserdoc['name']);
        });
      }
    }
  }

  @override
  initState() {
    super.initState();
    //  userlist = referenceUserList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 181, 196, 205),
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(67, 2, 118, 128),
              Color.fromARGB(127, 181, 196, 205),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80.0),
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
                SizedBox(height: 15.0),
                const Text(
                  'Please log in to continue',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
                SizedBox(height: 60.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Your Name',
                    labelStyle: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade900),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      usernumber = usernumberTextController.text;
                      getData();
                      //print(usernumber);
                    });
                  },
                  controller: usernumberTextController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Number',
                    labelStyle: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade900),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: ElevatedButton(
                    onPressed: () {
                      print(widget.gotdata);
                      if (widget.gotdata == 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      finaluserdoc: finaluserdoc,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      }
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
                      'Login',
                      style: TextStyle(color: Colors.blueGrey.shade900),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 56, 55, 55),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                ),
                Text(
                  'Only for Hotel Admins',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[700],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
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
                      backgroundColor:
                          MaterialStateProperty.all(ColorName.yellow),
                      elevation: MaterialStateProperty.all(0),
                      minimumSize:
                          MaterialStateProperty.all(const Size(220, 50)),
                    ),
                    child: Text(
                      'Admin',
                      style: TextStyle(color: Colors.blueGrey.shade900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
