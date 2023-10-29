import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine_on_way/screens/landing_page.dart';
import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userRef = FirebaseFirestore.instance.collection('user list');
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController usernumberTextController =
      TextEditingController();
  var username = '';
  var usernumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 181, 196, 205),
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
                  'Sign Up Quickly',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
                SizedBox(height: 15.0),
                const Text(
                  'Enter Details to Register',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                ),
                SizedBox(height: 60.0),
                TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      username = usernameTextController.text;
                    });
                  },
                  controller: usernameTextController,
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
                    onPressed: () async {
                      var flag = 0;
                      final querySnapshot = await userRef.get();
                      for (final docSnapshot in querySnapshot.docs) {
                        // print(docSnapshot['number']);
                        if (docSnapshot['number'] == usernumber) {
                          flag = 1;
                        }
                      }
                      if (flag == 0) {
                        setState(() {
                          userRef.add({'name': username, 'number': usernumber});
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage()));
                        });
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
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
                      'Sign Up',
                      style: TextStyle(color: Colors.blueGrey.shade900),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
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
                                builder: (context) => LandingPage()));
                      },
                      child: const Text(
                        'Sign In',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
