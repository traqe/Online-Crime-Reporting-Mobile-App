import 'package:flutter/material.dart';
import 'package:project_app/admin/adminComplaintspage.dart';
import 'package:project_app/admin/adminCrimespage.dart';
import 'package:project_app/admin/adminMissingpage.dart';
import 'package:project_app/database.dart';

class adminHomePage extends StatefulWidget {
  const adminHomePage({Key? key}) : super(key: key);

  @override
  State<adminHomePage> createState() => _adminHomePageState();
}

class _adminHomePageState extends State<adminHomePage> {
  late Database db;

  // crimes latest
  String headlineLatest = '';
  String imageCrimeUrl = '';
  // imageAsset latest

  // missing latest
  String nameLatest = '';
  int ageLatest = 0;
  String imageMissingUrl = '';
  // imageAsset

  // complaint latest
  String subjectLatest = '';

  initialise() {
    db = Database();
    db.initiliase();
    db.readCrimes().then((value) => {
          if (this.mounted)
            {
              setState(() {
                docCrimes = value!;
                headlineLatest = docCrimes[0]['headline'];
                imageCrimeUrl = docCrimes[0]['image'];
              })
            }
        });
    db.readMissing().then((value) => {
          if (this.mounted)
            {
              setState(() {
                docMissing = value!;
                nameLatest = docMissing[0]['name'];
                ageLatest = docMissing[0]['age'];
                imageMissingUrl = docMissing[0]['image'];
              })
            }
        });
    db.readComplaints().then((value) => {
          if (this.mounted)
            {
              setState(() {
                docComplaints = value!;
                subjectLatest = docComplaints[0]['subject'];
              })
            }
        });
  }

  List docCrimes = [];
  List docMissing = [];
  List docComplaints = [];

  @override
  void initState() {
    super.initState();
    initialise();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          title: const Text('CrimeRepo'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white70,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Crimes'),
              Tab(text: 'Missing'),
              Tab(text: 'Complaints'),
            ],
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 32.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 45.0,
                                  color: Colors.white,
                                ), // to be changed to image avatar
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                                child: Text(
                                  'Hello, Admin.',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                'Read, report, become acquainted!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              /* const Text(
                                'You have {0} unread reports',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white70,
                                ),
                              ), */
                              const SizedBox(
                                height: 25.0,
                              ),
                              const Text(
                                'Latest',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                height: 250.0,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    // crime latest card
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        width: 270,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text('Crime'),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              height: 150.0,
                                              width: 200.0,
                                              child: Flexible(child: Image.network(imageCrimeUrl)),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    headlineLatest,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // missing latest card
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        width: 270,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text('Missing'),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              height: 150.0,
                                              width: 200.0,
                                              child: Flexible(child: Image.network(imageMissingUrl)),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    nameLatest +
                                                        ' (${ageLatest.toString()})',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // complaint latest card
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        width: 270,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text('Complaint'),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    subjectLatest,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), // home content here.
            const adminCrimesPage(),
            const adminMissingPage(),
            const adminComplaintsPage(),
          ],
        ),
      ),
    );
  }
}
