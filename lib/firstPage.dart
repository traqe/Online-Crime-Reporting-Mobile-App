import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_app/crimes.dart';
import 'package:project_app/crimespage.dart';
import 'package:project_app/missingpage.dart';
import 'package:project_app/screens/login_screen.dart';

import 'missing.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 120.0,
          ),
          SizedBox(
              height: 100,
              child: Image.asset(
                "images/logo.png",
                fit: BoxFit.contain,
              )),
          const SizedBox(
            height: 22.0,
          ),
          const Text(
            'Crime Reporting System',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
              margin: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          primary: Colors.white,
                          minimumSize: const Size.fromHeight(20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (const Crimes())));
                      },
                      child: const Text(
                        'View crimes',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Colors.white,
                        minimumSize: const Size.fromHeight(20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Missing()));
                      },
                      child: const Text('View Missing People ',
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Colors.white,
                        minimumSize: const Size.fromHeight(20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text('Login',
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
