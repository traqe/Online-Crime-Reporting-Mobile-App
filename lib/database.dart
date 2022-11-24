import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  late FirebaseFirestore firestore;

  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  // crimes read
  Future<List?> readCrimes() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('crimes')
          .orderBy('Timestamp', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "street": doc['street'],
            "city": doc['city'],
            "zipcode": doc['zipcode'],
            "headline": doc['headline'],
            "crime details": doc['crime details'],
            "Timestamp": doc['Timestamp'],
            "status": doc['status'],
            "image": doc['image']
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  // missing read
  Future<List?> readMissing() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('missing')
          .orderBy('timestamp', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "age": doc['age'],
            "details": doc['details'],
            "gender": doc['gender'],
            "lastseen": doc['lastseen'],
            "name": doc['name'],
            "timestamp": doc['timestamp'],
            "status": doc['status'],
            "image": doc['image']
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  // complaints read
  Future<List?> readComplaints() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore
          .collection('complaints')
          .orderBy('timestamp', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "address": doc['address'],
            "city": doc['city'],
            "complaint": doc['complaint'],
            "pincode": doc['pincode'],
            "subject": doc['subject'],
            "timestamp": doc['timestamp'],
            "status": doc['status'],
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }
}
