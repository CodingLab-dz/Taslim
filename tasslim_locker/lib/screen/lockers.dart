import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tasslim_locker/screen/landing.dart';
import 'package:tasslim_locker/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Lockers extends StatefulWidget {
  List serrurs = [];
  Lockers({super.key, required this.serrurs});
  @override
  State<Lockers> createState() => _LockersState();
}

class _LockersState extends State<Lockers> {
  bool ouvert = false;
  final dbref = FirebaseDatabase.instance.ref();
  @override
  int _selectedIndex = 0;
  _ontest(String test) {
    if (test == "oui") {
      setState(() {
        ouvert = true;
      });
    } else {
      setState(() {
        ouvert = false;
      });
    }
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  /*open(String serrur) async {
    bool test = await Databaseservece.updatetat(serrur);
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Landing()));
            },
            icon: const Icon(
              Icons.logout,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: /*ListView.builder(
                  itemCount: widget.serrurs.length,
                  itemBuilder: (_, i) {
                    return FirebaseAnimatedList(
                        query:
                            dbref.child('lockers/resrv1/${widget.serrurs[i]}'),
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          print(snapshot);
                          var itemdata = snapshot.value;
                          return ListTile(
                            title: Text("${itemdata}"),
                          );
                        });
                  },
                ),*/
                    ListView.builder(
                  itemCount: widget.serrurs.length,
                  itemBuilder: (_, index) {
                    return StreamBuilder(
                      stream: dbref
                          .child(
                              'lockers/resrv1/${widget.serrurs[index]}/ouvrir')
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data?.snapshot.value != null) {
                          var ouvrirValue =
                              snapshot.data?.snapshot.value.toString();
                          return InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color:
                                    snapshot.data?.snapshot.value.toString() ==
                                                "oui" &&
                                            _selectedIndex != null &&
                                            _selectedIndex == index
                                        ? Colors.green[400]
                                        : Colors.white,
                              ),
                              child: ListTile(
                                title: Text(ouvrirValue!),
                              ),
                            ),
                            onTap: () {
                              Databaseservece()
                                  .updatetat("${widget.serrurs[index]}");
                              Databaseservece()
                                  .updatetat2("${widget.serrurs[index]}");
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                    /*FutureBuilder(
                      future: dbref
                          .child(
                              'lockers/resrv1/${widget.serrurs[index]}/ouvrir')
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DataSnapshot> snapshot) {
                        if (snapshot.data?.value == "oui") {
                          print("oui");
                        } else {
                          print("non");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: snapshot.data?.value == "oui" &&
                                      _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? Colors.green[400]
                                  : Colors.white,
                            ),
                            child: ListTile(
                              title: Text('${widget.serrurs[index]}'),
                            ),
                          ),
                          onTap: () async {
                            if (snapshot.data?.value == "non") {
                              await Databaseservece()
                                  .updatetat("${widget.serrurs[index]}");
                              setState(() {
                                ouvert = true;
                              });
                              print("ouvrir");
                            }
                            if (snapshot.data?.value == "oui") {
                              await Databaseservece()
                                  .updatetat2("${widget.serrurs[index]}");
                              setState(() {
                                ouvert = false;
                              });
                              print("ferme");
                            }
                            ;
                          },
                        );
                      },
                    );*/
                    /*return InkWell(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: ouvert &&
                                  _selectedIndex != null &&
                                  _selectedIndex == index
                              ? Colors.green[400]
                              : Colors.white,
                        ),
                        child: ListTile(
                          title: Text("${widget.serrurs[index]}"),
                        ),
                      ),
                      onTap: () async {
                        if (!ouvert) {
                          await Databaseservece()
                              .updatetat("${widget.serrurs[index]}");
                          setState(() {
                            ouvert = true;
                          });
                        }
                      },
                    );*/
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
