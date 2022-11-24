import 'package:flutter/material.dart';
import 'package:project_app/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class adminCrimesPage extends StatefulWidget {
  const adminCrimesPage({Key? key}) : super(key: key);

  @override
  State<adminCrimesPage> createState() => _adminCrimesPageState();
}

class _adminCrimesPageState extends State<adminCrimesPage> {
  late Database db;
  List docs = [];
  String image = '';
  String status = '';
  String id = '';
  String street = '';
  String city = '';
  int zipcode = 0;
  String headline = '';
  String crimedetails = '';

  Initialise() {
    db = Database();
    db.initiliase();
    db.readCrimes().then((value) => {
          if (this.mounted)
            {
              setState(() {
                docs = value!;
              })
            }
        });
  }

  TextEditingController adminCrimeController = TextEditingController();
  popUpContainer(
      context, street, city, zipcode, headline, crimedetails, status, image) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.94,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 270.0,
                        width: 350.0,
                        child: Image.network(image),
                      ), // street, city, zipcode, headline, crime details
                      Padding(
                        padding: EdgeInsets.fromLTRB(51.0, 8.0, 56.0, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    status,
                                    style: TextStyle(fontSize: 45.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(child:Text('Street: ' + street)),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('City: ' + city)),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Zipcode: ' + zipcode.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(child:Text('Headline: ' + headline)),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Crime Details: ' + crimedetails),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Status: '),
                                SizedBox(
                                    width: 165.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        controller: adminCrimeController,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          labelText: 'Crime',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.deepPurple,),
                                          ),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    onPressed: () {
                                      print(id);

                                      FirebaseFirestore.instance
                                          .collection('crimes')
                                          .doc(id)
                                          .update({
                                        'status': adminCrimeController.text
                                      });
                                      adminCrimeController.clear();
                                    },
                                    child: Text('Update'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Initialise();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[900],
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                setState(() {
                  id = docs[index]['id'];
                  street = docs[index]['street'];
                  city = docs[index]['city'];
                  zipcode = docs[index]['zipcode'];
                  headline = docs[index]['headline'];
                  crimedetails = docs[index]['crime details'];
                  status = docs[index]['status'];
                  image = docs[index]['image'];
                });

                popUpContainer(context, street, city, zipcode, headline,
                    crimedetails, status, image);
              },
              child: Container(
                height: 320.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('Headline: ' + docs[index]['headline'],
                              style: TextStyle(fontWeight: FontWeight.w600),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        children: [
                          Expanded(child:Text('Street: ' + docs[index]['street'])),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        child: Flexible(child: Image.network(docs[index]['image'])),
                        height: 220.0,
                        width: 300.0,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        children: [
                      Expanded(child:Text('Status: ' + docs[index]['status'])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
