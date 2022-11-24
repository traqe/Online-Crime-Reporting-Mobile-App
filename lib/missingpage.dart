import 'package:flutter/material.dart';
import 'package:project_app/database.dart';

popUpContainer(context, name, age, lastseen, details, gender, image) {
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
                      child: Flexible(child: Image.network(image)),
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

class MissingPage extends StatefulWidget {
  const MissingPage({Key? key}) : super(key: key);

  @override
  State<MissingPage> createState() => _MissingPageState();
}

class _MissingPageState extends State<MissingPage> {
  late Database db;
  List docs = [];

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
                  name = docs[index]['name'];
                  age = docs[index]['age'];
                  lastseen = docs[index]['lastseen'];
                  details = docs[index]['details'];
                  gender = docs[index]['gender'];
                  image = docs[index]['image'];
                });
                popUpContainer(context, name, age, lastseen, details, gender, image);
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
                        child: Flexible(child: Image.network(docs[index]['image'], height: 100.0,)),
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
