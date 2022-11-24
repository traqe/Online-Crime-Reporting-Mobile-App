import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

enum genderGroup { male, female, other }

class AddNewMissing extends StatefulWidget {
  const AddNewMissing({Key? key}) : super(key: key);

  @override
  State<AddNewMissing> createState() => _AddNewMissingState();
}

class _AddNewMissingState extends State<AddNewMissing> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController lastseenController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();
  String gender = "Male";

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  String filename = '';

  /// returns image download url if successful
  Future<String?> _uploadImageToCloud() async {
    final storageRef = FirebaseStorage.instance.ref();

// Points to "files"
    final filesRef = storageRef.child("files/$filename");
    try {
      // Upload raw data.
      await filesRef.putData(webImage);

      final _imgUrl = await filesRef.getDownloadURL();

      log('image download url: $_imgUrl');

      return _imgUrl;
    }

    //
    on firebase_core.FirebaseException catch (e) {
      log(e.message ?? 'failed to upload to cloud storage');
    }

    //
    catch (e) {
      log('error uploading to firebase: $e');
    }

    return null;
  }

  Widget _buildName() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: nameController,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'Name',
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

  Widget _buildAge() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: ageController,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'Age',
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

  Widget _buildLastSeen() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: lastseenController,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'Last Seen',
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

  Widget _buildDetails() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: detailsController,
      maxLength: null,
      decoration: InputDecoration(
        labelText: 'Details',
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

  genderGroup _value = genderGroup.male;

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          filename = image.name;
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          filename = image.name;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget dottedBorder({required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        dashPattern: const [6.7],
        borderType: BorderType.RRect,
        color: color,
        radius: const Radius.circular(12),
        child: SizedBox(
          width: 180,
          height: 180,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                color: color,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: (() {
                    _pickImage();
                  }),
                  child: const Text('Choose an image')),
            ],
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          elevation: 0,
          centerTitle: true,
          title: const Text('New missing'),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0,24,30.0,24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 12.0,),
                  _buildName(),
                  _buildAge(),
                  _buildLastSeen(),
                  _buildDetails(),
                  SizedBox(height: 12.0),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Gender:",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RadioListTile(
                            value: genderGroup.male,
                            title: const Text(
                              "Male",
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            groupValue: _value,
                            onChanged: (genderGroup? val) {
                              setState(() {
                                _value = val!;
                                gender = "Male";
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RadioListTile(
                            value: genderGroup.female,
                            title: const Text("Female",
                                style: TextStyle(fontSize: 15, color: Colors.white)),
                            groupValue: _value,
                            onChanged: (genderGroup? val) {
                              setState(() {
                                _value = val!;
                                gender = "Female";
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RadioListTile(
                            value: genderGroup.other,
                            title: const Text("Others",
                                style: TextStyle(fontSize: 15, color: Colors.white)),
                            groupValue: _value,
                            onChanged: (genderGroup? val) {
                              setState(() {
                                _value = val!;
                                gender = "Others";
                              });
                            }),
                      ),
                    ],
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Upload an image",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  const SizedBox(height: 10),
                  Container(
                    child: _pickedImage == null
                        ? dottedBorder(color: Colors.white)
                        : kIsWeb
                            ? Image.memory(webImage,
                                width: 180, height: 180, fit: BoxFit.contain)
                            : Image.file(_pickedImage!,
                                width: 180, height: 180, fit: BoxFit.fill),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      title: 'Browse',
                      icon: Icons.image_outlined,
                      onClick: _pickImage),
                  const SizedBox(height: 20),
                  SubmitButton(
                      title: 'Report Missing Person',
                      onClick: (() async {
                        final name = nameController.text;
                        final age = int.parse(ageController.text);
                        final lastseen = lastseenController.text;
                        final details = detailsController.text;
                        final time = Timestamp.now();
                        String status = "Pending";

                        // upload img to cloud
                        final _url = await _uploadImageToCloud();

                        createMissing(
                            imgUrl: _url,
                            name: name,
                            age: age,
                            lastseen: lastseen,
                            time: time,
                            status: status,
                            details: details,
                            gender: gender);

                        nameController.clear();
                        ageController.clear();
                        lastseenController.clear();
                        detailsController.clear();
                      })),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(title),
          ],
        ),
      ));
}

Widget SubmitButton({
  required String title,
  required VoidCallback onClick,
}) {
  return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Text(title),
          ],
        ),
      ));
}

Future createMissing(
    {required String name,
    String? imgUrl,
    required int age,
    required String lastseen,
    required Timestamp time,
    required String status,
    required String details,
    required String gender}) async {
  final docMissing = FirebaseFirestore.instance.collection("missing").doc();

  final json = {
    'name': name,
    'image': imgUrl ?? 'https://firebasestorage.googleapis.com/v0/b/crime-reporting-system-cc4b6.appspot.com/o/files%2Fmissing.png?alt=media&token=1363ecc0-804e-41b1-a5a3-4f037b873472',
    'age': age,
    'lastseen': lastseen,
    'details': details,
    'timestamp': time,
    'gender': gender,
    'status': status
  };

  await docMissing.set(json);
}
