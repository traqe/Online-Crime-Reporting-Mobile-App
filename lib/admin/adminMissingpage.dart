import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_app/database.dart';

class adminMissingPage extends StatefulWidget {
  const adminMissingPage({Key? key}) : super(key: key);

  @override
  State<adminMissingPage> createState() => _adminMissingPageState();
}

class _adminMissingPageState extends State<adminMissingPage> {
  late Database db;
  List docs = [];
  String status = '';
  String id = '';
  String name = '';
  int age = 0;
  String lastseen = '';
  String details = '';
  String gender = '';
  String image = '';

  Initialise() {
    db = Database();
    db.initiliase();
    db.readMissing().then((value) => {
          if (this.mounted)
            {
              setState(() {
                docs = value!;
              })
            }
        });
  }

  TextEditingController adminMissingController = TextEditingController();

  popUpContainer(context, name, age, lastseen, details, gender, status, image) {
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
                                Text(
                                  status,
                                  style: TextStyle(fontSize: 45.0),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Name: ' + name)),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Age: ' + age.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Last Seen: ' + lastseen)),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Details: ' + details),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Gender: ' + gender),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Update Status: '),
                                SizedBox(
                                    width: 115.0,
                                    child: TextFormField(
                                      controller: adminMissingController,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter status',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.deepPurple),
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
                                          .collection('missing')
                                          .doc(id)
                                          .update({
                                        'status': adminMissingController.text
                                      });
                                      adminMissingController.clear();
                                    },
                                    child: Text('Update'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    onPressed: () {
                                      adminMissingController.clear();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                )
                              ],
                            )
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
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                setState(() {
                  id = docs[index]['id'];
                  name = docs[index]['name'];
                  age = docs[index]['age'];
                  lastseen = docs[index]['lastseen'];
                  details = docs[index]['details'];
                  gender = docs[index]['gender'];
                  status = docs[index]['status'];
                  image = docs[index]['image'];
                });
                popUpContainer(
                    context, name, age, lastseen, details, gender, status, image);
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
                            child: Text("Person's name: " + docs[index]['name'],
                              style: TextStyle(fontWeight: FontWeight.w600),),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text('(' + docs[index]['age'].toString() + ')'),
                        ],
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Person's last seen: " + docs[index]['lastseen'])),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        child: Flexible(child: Image.network(docs[index]['image']),),
                        height: 220.0,
                        width: 300.0,
                        color: Colors.black45,
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Status: ' + docs[index]['status'])),
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
