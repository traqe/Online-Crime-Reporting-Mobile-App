import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_app/database.dart';

class adminComplaintsPage extends StatefulWidget {
  const adminComplaintsPage({Key? key}) : super(key: key);

  @override
  State<adminComplaintsPage> createState() => _adminComplaintsPageState();
}

class _adminComplaintsPageState extends State<adminComplaintsPage> {
  late Database db;
  List docs = [];

  String status = '';
  String id = '';
  String address = '';
  String city = '';
  int pincode = 0;
  String subject = '';
  String complaint = '';

  Initialise() {
    db = Database();
    db.initiliase();
    db.readComplaints().then((value) => {
          if (this.mounted)
            {
              setState(() {
                docs = value!;
              })
            }
        });
  }

  TextEditingController admincomplaintController = TextEditingController();

  popUpContainer(context, address, city, pincode, subject, complaint, status) {
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
                height: MediaQuery.of(context).size.height * 0.60,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                                Expanded(child: Text('Address: ' + address)),
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
                                Text('Pin Code: ' + pincode.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Subject: ' + subject),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Complaint: ' + complaint,
                                  ),
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
                                    child: TextFormField(
                                      controller: admincomplaintController,
                                      maxLines: null,
                                      decoration: const InputDecoration(
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
                                          .collection('complaints')
                                          .doc(id)
                                          .update({
                                        'status': admincomplaintController.text
                                      });
                                      admincomplaintController.clear();
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
                                      admincomplaintController.clear();
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
    admincomplaintController = TextEditingController(text: status);
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
              child: InkWell(
                onTap: () {
                  setState(() {
                    id = docs[index]['id'];
                    address = docs[index]['address'];
                    city = docs[index]['city'];
                    pincode = docs[index]['pincode'];
                    subject = docs[index]['subject'];
                    complaint = docs[index]['complaint'];
                    status = docs[index]['status'];
                  });
                  popUpContainer(context, address, city, pincode, subject,
                      complaint, status);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('Subject: ' + docs[index]['subject'],
                              style: TextStyle(fontWeight: FontWeight.w600),),
                          ),
                        ],
                      ),
                      SizedBox(
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
            );
          }),
    );
  }
}
