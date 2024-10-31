import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/model/diarioModel.dart';
import 'package:crud/service/HomeService.dart';
import 'package:crud/view/cardView.dart';
import 'package:crud/view/registrarView.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  //Widget para adicionar o layout da página inicial da aplicação.
  @override
  Widget build(BuildContext context) {
    HomeService homeService = HomeService();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 218, 171),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Diário Pessoal",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    //Método assíncrono para buscar as informações do banco de dados e com isso montar o(s) card(s) para exibir na tela inicial.
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: homeService.getTodosDiarios(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return Column(
                              // Busca os dados do banco tirando uma "foto" do banco de dados atual e trás as informações para serem utilizadas.
                              children: snapshot.data!.docs.asMap().entries.map((entry) {
                                final doc = entry.value;
                                final data = doc.data();
                                return CardDiario(
                                  diario: DiarioModel(id: doc.id, uuid: data['uuid'], titulo: data['titulo'], descricao: data['descricao'], data: data['data'], imagemUrl: data['imagemUrl']),
                                );
                              }).toList(),
                            );
                          }
                        } else {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Nenhum diário cadastrado",
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistrarView(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 169, 173, 148),
        tooltip: 'Adicionar diário',
        child: const Icon(Icons.add),
      ),
    );
  }
}
