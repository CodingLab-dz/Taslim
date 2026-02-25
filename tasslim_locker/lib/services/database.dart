import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Databaseservece {
  final CollectionReference tasslimeCollection =
      FirebaseFirestore.instance.collection("users");
  final dbref = FirebaseDatabase.instance.ref();

  /*Future searchUser(String id, String pass) async {
    
    return await tasslimeCollection.doc("user1");

  }*/
  Stream<QuerySnapshot> get users {
    return tasslimeCollection.snapshots();
  }

  Future getUsers() async {
    List list = [];
    try {
      await tasslimeCollection.get().then((querysnapshot) {
        for (var doc in querysnapshot.docs) {
          list.add(doc.data());
        }
      });
      return list;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUser(String id, String pass) async {
    var user;
    try {
      await tasslimeCollection
          .where('id', isEqualTo: id)
          .where('pass', isEqualTo: pass)
          .get()
          .then((querysnapshot) => {
                for (var doc in querysnapshot.docs) {user = doc.id}
              });
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getreserv(String uid) async {
    var rsrv;
    try {
      await tasslimeCollection
          .doc(uid)
          .collection("resrvations")
          .doc("resrv1")
          .get()
          .then((value) => {rsrv = value.data()});
      return rsrv;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updatetat(String serrure) async {
    final snapshot = await dbref.child('lockers/resrv1').get();
    if (snapshot.exists) {
      await dbref
          .child('lockers/resrv1/' + serrure + '')
          .update({"ouvrir": "oui"});
      return true;
    }
  }

  Future updatetat2(String serrure) async {
    final snapshot = await dbref.child('lockers/resrv1').get();
    if (snapshot.exists) {
      await dbref
          .child('lockers/resrv1/' + serrure + '')
          .update({"etat": "ouvrir"});
      return true;
    }
  }
}
