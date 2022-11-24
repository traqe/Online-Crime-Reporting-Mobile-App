import 'package:flutter/material.dart';
import 'package:project_app/database.dart';

class Crimes extends StatefulWidget {
  const Crimes({Key? key}) : super(key: key);

  @override
  State<Crimes> createState() => _CrimesState();
}

class _CrimesState extends State<Crimes> {
  late Database db;
  List docs = [];

  String image = '';
  String street = '';
  String city = '';
  int zipcode = 0;
  String headline = '';
  String crimedetails = '';

  popUpContainer(
      context, street, city, zipcode, headline, crimedetails, image) {
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
                height: MediaQuery.of(context).size.height * 0.97,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Flexible(child: Image.network(image)),
                        height: 270.0,
                        width: 350.0,
                        color: Colors.black45,
                      ), // street, city, zipcode, headline, crime details
                      Padding(
                        padding: EdgeInsets.fromLTRB(51.0, 8.0, 56.0, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Street: ' + street)),
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
                                Expanded(child: Text('Headline: ' + headline)),
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

  @override
  void initState() {
    super.initState();
    Initialise();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[900],
        title: const Text('Crimes'),
      ),
      body: Container(
        color: Colors.deepPurple[900],
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  print(image);
                  setState(() {
                    street = docs[index]['street'];
                    city = docs[index]['city'];
                    zipcode = docs[index]['zipcode'];
                    headline = docs[index]['headline'];
                    crimedetails = docs[index]['crime details'];
                    image = docs[index]['image'];
                  });

                  popUpContainer(context, street, city, zipcode, headline,
                      crimedetails, image);
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
                              child: Text(
                                'Headline: ' + docs[index]['headline'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Text('Street: ' + docs[index]['street'])),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: Flexible(
                              child: Image.network(docs[index]['image'])),
                          height: 220.0,
                          width: 300.0,
                          color: Colors.black45,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
