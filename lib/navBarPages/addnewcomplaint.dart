import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewComplaint extends StatefulWidget {
  const AddNewComplaint({Key? key}) : super(key: key);

  @override
  State<AddNewComplaint> createState() => _AddNewComplaintState();
}

class _AddNewComplaintState extends State<AddNewComplaint> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  TextEditingController complaintController = new TextEditingController();

  Widget _buildAddress() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: addressController,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Address',
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },

      /*validator: (value) {
        if (value!.isNotEmpty && value.length > 2) {
          return null;
        } else if (value.length < 3 && value.isNotEmpty) {
          return 'No way your name is that short';
        } else {
          return 'Name is required';
        }
      },*/
    );
  }

  Widget _buildCity() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: cityController,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'City',
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },

      // reg expression for email validation
      /*if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;*/
    );
  }

  Widget _buildPinCode() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: pincodeController,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'Pin code',
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget _buildSubject() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: subjectController,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: 'Subject',
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget _buildComplaint() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: complaintController,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Complaint',
        labelStyle: TextStyle(color: Colors.white70),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      ),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        elevation: 0,
        centerTitle: true,
        title: const Text('New complaint'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30.0,24,30.0,24),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 12.0,),
                _buildAddress(),
                _buildCity(),
                _buildPinCode(),
                _buildSubject(),
                _buildComplaint(),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data', style: TextStyle(
                          color: Colors.deepPurple[900],
                          ),
                         )
                        ),
                      );
                    }
                    final address = addressController.text;
                    final city = cityController.text;
                    final pincode = int.parse(pincodeController.text);
                    final subject = subjectController.text;
                    final complaint = complaintController.text;
                    final time = Timestamp.now();
                    String status = "Pending";

                    createComplaint(
                        address: address,
                        city: city,
                        complaint: complaint,
                        pincode: pincode,
                        status: status,
                        subject: subject,
                        time: time);

                    addressController.clear();
                    cityController.clear();
                    complaintController.clear();
                    pincodeController.clear();
                    subjectController.clear();
                  },
                  child: const Text('Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                ),
              ],
            )),
      ),
    );
  }
}

Future createComplaint(
    {required String address,
    required String city,
    required String complaint,
    required int pincode,
    required String status,
    required String subject,
    required Timestamp time}) async {
  final docComplaint =
      FirebaseFirestore.instance.collection("complaints").doc();

  final json = {
    'address': address,
    'city': city,
    'complaint': complaint,
    'pincode': pincode,
    'status': status,
    'timestamp': time,
    'subject': subject
  };

  await docComplaint.set(json);
}
