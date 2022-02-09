import 'dart:developer';

import 'package:fichacell/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5F249F),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      "FichaCell",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: email,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Digite seu Email",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Digite sua Senha",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: TextButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          if (userCredential.user != null) {
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Home(),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            log("", error: 'Conta não cadastrada');
                          } else if (e.code == 'wrong-password') {
                            log("", error: 'A senha está incorreta');
                          } else {
                            log("", error: 'Usuário/Senha incorreto(s)');
                          }
                        }
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "medium",
                        ),
                      ),
                    ),
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
