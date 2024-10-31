import 'dart:io';

import 'package:crud/service/registrarService.dart';
import 'package:crud/view/homeView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrarView extends StatefulWidget {
  const RegistrarView({super.key});

  @override
  _RegistrarView createState() => _RegistrarView();
}

class _RegistrarView extends State<RegistrarView> {
  final TextEditingController cpTitulo = TextEditingController();
  final TextEditingController cpDescricao = TextEditingController();
  final TextEditingController cpImagem = TextEditingController();
  final RegistrarService registrarService = RegistrarService();

  //Widget para adicionar o layout de registro de diários da aplicação.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 218, 171),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: cpTitulo,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Título do diário",
                        filled: true,
                        fillColor: Color.fromARGB(255, 218, 189, 123),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: cpDescricao,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Descrição",
                        filled: true,
                        fillColor: Color.fromARGB(255, 218, 189, 123),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: cpImagem,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "URL para imagem no card",
                        filled: true,
                        fillColor: Color.fromARGB(255, 218, 189, 123),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            //Verificação para ver se os campos não estão nulos.
                            if (cpTitulo.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Campo Título é obrigatório!'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (cpDescricao.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Campo Descrição é obrigatório!'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (cpImagem.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Campo URL para imagem é obrigatório!'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              try {
                                //Método chamado para adicionar as informações cadastradas no firebase.
                                registrarService.addDiario(cpTitulo.text, cpDescricao.text, cpImagem.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Diário registrado com sucesso!'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Não foi possível adicionar um novo diário!'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          ),
                          child: const Text(
                            "Salvar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey
                        ),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}