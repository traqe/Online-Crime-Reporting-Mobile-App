import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AddNewCrime extends StatefulWidget {
  const AddNewCrime({Key? key}) : super(key: key);

  @override
  State<AddNewCrime> createState() => _AddNewCrimeState();
}

class _AddNewCrimeState extends State<AddNewCrime> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cityController = new TextEditingController();
  TextEditingController crimedetailsController = new TextEditingController();
  TextEditingController headlineController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController zipcodeController = new TextEditingController();

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

  Widget _buildStreet() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: streetController,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'Street',
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

  Widget _buildZipCode() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: zipcodeController,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'Zipcode',
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

  Widget _buildHeadline() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: headlineController,
      maxLength: 30,
      decoration: InputDecoration(
        labelText: 'Headline',
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

  Widget _buildCrimeDetails() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: crimedetailsController,
      maxLines: null,
      decoration: const InputDecoration(

        labelText: 'Crime Details',
        labelStyle: TextStyle(color: Colors.white70),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
          width: 250,
          height: 250,
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
                  child: const Text('Choose an image',)),
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
        title: const Text('New crime'),
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
                  _buildStreet(),
                  _buildCity(),
                  _buildZipCode(),
                  _buildHeadline(),
                  _buildCrimeDetails(),
                  const SizedBox(height: 20),
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
                    title: 'Report Crime',
                    onClick: () async {
                      //  assigning data to variables
                      final city = cityController.text;
                      final crimedetails = crimedetailsController.text;
                      final headline = headlineController.text;
                      final street = streetController.text;
                      final zipcode = int.parse(zipcodeController.text);
                      final time = Timestamp.now();
                      String status = "Pending";

                      // upload img to cloud
                      final _url = await _uploadImageToCloud();

                      //insert function before this
                      createCrime(
                          imgUrl: _url,
                          city: city,
                          crimedetails: crimedetails,
                          headline: headline,
                          street: street,
                          zipcode: zipcode,
                          time: time,
                          status: status);

                      cityController.clear();
                      crimedetailsController.clear();
                      headlineController.clear();
                      streetController.clear();
                      zipcodeController.clear();
                    },
                  ),
                ],
              ),
            )),
      ),
    );
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
        child: Container(
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 20,
              ),
              Text(title),
            ],
          ),
        ),
      ));
}

Widget SubmitButton({
  required String title,
  required VoidCallback onClick,
}) {
  return Container(
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

// func to insert data into firebase.
Future createCrime(
    {required String city,
    String? imgUrl,
    required String crimedetails,
    required String headline,
    required String street,
    required int zipcode,
    required Timestamp time,
    required String status}) async {
  final docCrime = FirebaseFirestore.instance.collection("crimes").doc();

  final json = {
    'city': city,
    'image': imgUrl ?? 'https://firebasestorage.googleapis.com/v0/b/crime-reporting-system-cc4b6.appspot.com/o/files%2Fcrime_image.jpg?alt=media&token=1b38f497-128f-41c8-917c-a0048e2b6989',
    'crime details': crimedetails,
    'headline': headline,
    'street': street,
    'zipcode': zipcode,
    'Timestamp': time,
    'status': status
  };

  await docCrime.set(json);
}
