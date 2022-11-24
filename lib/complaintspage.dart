import 'package:flutter/material.dart';
import 'package:project_app/database.dart';

popUpContainer(context, address, city, pincode, subject, complaint) {
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
                            height: 30.0,
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

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  late Database db;
  List docs = [];

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

  @override
  void initState() {
    super.initState();
    Initialise();
  }

  Widget build(BuildContext context) {
    return ListView.builder(
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
                  address = docs[index]['address'];
                  city = docs[index]['city'];
                  pincode = docs[index]['pincode'];
                  subject = docs[index]['subject'];
                  complaint = docs[index]['complaint'];
                });
                popUpContainer(
                    context, address, city, pincode, subject, complaint);
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
        });
  }
}
