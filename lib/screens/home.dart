import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fichacell/screens/edit.dart';
import 'package:fichacell/screens/login.dart';
import 'package:fichacell/screens/new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
      floatingActionButton: FloatingActionButton(
        heroTag: "new",
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => New(),
            ),
          );
          setState(() {});
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.add_rounded, color: Colors.black),
      ),
      appBar: AppBar(
        title: Text("FichaCell"),
        backgroundColor: Color(0xFF5F249F),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                } catch (_) {
                  log("", error: "Erro");
                }
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future:
                    FirebaseFirestore.instance.collection("celulares").get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> docs) {
                  if (docs.hasData) {
                    log("", error: "${docs.data!.docs}");
                    return Column(
                      children: [
                        ...docs.data!.docs.map(
                          (e) => Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            height: 210,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset("images/lindo.jpeg"),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${e["modelo"]}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "${e["marca"]} ${e["ano"]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "${e["processador"]} ${e["ram"]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "${e["valor"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        "${e["descricao"]}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Center(
                                        child: TextButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => Edit(
                                                  doc: e,
                                                ),
                                              ),
                                            );
                                            setState(() {});
                                          },
                                          child: Text(
                                            "Editar",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: TextButton(
                                          onPressed: () async {
                                            await e.reference.delete();
                                            setState(() {});
                                          },
                                          child: Text(
                                            "Deletar",
                                            style: TextStyle(fontSize: 16),
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
                    );
                  }
                  return SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
