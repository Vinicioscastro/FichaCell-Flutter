import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  QueryDocumentSnapshot<Map<String, dynamic>> doc;
  Edit({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController nome;
  late TextEditingController marca;
  late TextEditingController ano;
  late TextEditingController processador;
  late TextEditingController ram;
  late TextEditingController valor;
  late TextEditingController desc;

  @override
  void initState() {
    nome = TextEditingController(text: "${widget.doc["modelo"]}");
    marca = TextEditingController(text: "${widget.doc["marca"]}");
    ano = TextEditingController(text: "${widget.doc["ano"]}");
    processador = TextEditingController(text: "${widget.doc["processador"]}");
    ram = TextEditingController(text: "${widget.doc["ram"]}");
    valor = TextEditingController(text: "${widget.doc["valor"]}");
    desc = TextEditingController(text: "${widget.doc["descricao"]}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Cadastro de Dispositivo",
                    style: TextStyle(fontSize: 18),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Nome"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: nome,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Nome do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text("Marca"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: marca,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Marca do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text("Ano de Lançamento"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: ano,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Ano do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text("Processador"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: processador,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Processador do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text("Mémoria Ram"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: ram,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Mémoria Ram do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text("Valor"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: valor,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Valor do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text("Discrição"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextField(
                      controller: desc,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration.collapsed(
                        hintText: "Descrição do Dispositivo",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        try {
                          await widget.doc.reference.update(
                            {
                              "ano": ano.text,
                              "descricao": desc.text,
                              "marca": marca.text,
                              "modelo": nome.text,
                              "processador": processador.text,
                              "ram": ram.text,
                              "valor": valor.text,
                            },
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          log("", error: "Erro ao adicionar");
                        }
                      },
                      child: Text(
                        "Salvar",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Voltar",
                        style: TextStyle(fontSize: 16),
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
