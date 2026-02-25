import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasslim_locker/screen/loading.dart';
import 'package:tasslim_locker/screen/lockers.dart';
import 'package:tasslim_locker/services/database.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List users = <dynamic>[];
  var user, rsrv;
  bool lowading = false;
  bool ex = false;
  @override
  void initState() {
    super.initState();
    //usersf();
  }

  usersf() async {
    dynamic usersv = await Databaseservece().getUsers();
    if (usersv == null) {
      print("no users");
    } else {
      setState(() {
        users = usersv;
        ex = true;
      });
    }
  }

  List serrurs = [];
  resrvF(String uid) async {
    dynamic rsrvs = await Databaseservece().getreserv(uid);
    if (rsrvs == null) {
      print("no rserv");
    } else {
      setState(() {
        rsrv = rsrvs;
        for (var element in rsrv['serrures']) {
          serrurs.add(element);
        }
      });
    }

    print(serrurs);
  }

  userf(String id, String pass) async {
    setState(() {
      lowading = true;
    });
    dynamic userv = await Databaseservece().getUser(id, pass);
    print(userv);
    if (userv == null) {
      print("no user");
      setState(() {
        lowading = false;
      });
    } else {
      setState(() {
        user = userv;
        resrvF(userv);
        Timer(Duration(seconds: 3), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Lockers(serrurs: serrurs)));
        });
        // Databaseservece().updatetat();
      });
    }
    print("eeee${userv}");
  }

  String id = '';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    //final tst = users;
    //Databaseservece().getUsers();
    return lowading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.deepPurple,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text(
                              "Logo",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  id = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 30),
                                labelText: "Identifiant",
                                helperStyle:
                                    const TextStyle(color: Colors.deepPurple),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  pass = value;
                                });
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 30),
                                labelText: "Mots de passe",
                                helperStyle:
                                    const TextStyle(color: Colors.deepPurple),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ],
                        ),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            "Suivant",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          onPressed: () async {
                            print(id);
                            print(pass);
                            setState(() {
                              userf(id, pass);
                            });
                          },
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/login.png"))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
