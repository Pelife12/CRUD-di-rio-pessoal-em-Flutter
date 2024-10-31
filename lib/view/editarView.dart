import 'package:crud/model/diarioModel.dart';
import 'package:crud/service/HomeService.dart';
import 'package:crud/service/editarService.dart';
import 'package:crud/view/homeView.dart';
import 'package:flutter/material.dart';

class EditarView extends StatefulWidget {
  final DiarioModel diario;
  //Parâmetro necessário para adicionar as informações nos campos de edição.
  const EditarView({
    super.key,
    required this.diario,
  });

  @override
  _EditarView createState() => _EditarView();
}

class _EditarView extends State<EditarView> {
  late final TextEditingController cpTitulo;
  late final TextEditingController cpDescricao;
  late final TextEditingController cpImagem;
  late final DiarioModel diario;
  final HomeService homeService = HomeService();

  //Inicializa a variável com as informações passadas no parâmetro.
  @override
  void initState() {
    super.initState();
    diario = widget.diario;
  }

  //Widget para adicionar o layout de edições dos diários da aplicação.
  @override
  Widget build(BuildContext context) {
    EditarService editarService = EditarService();
    cpTitulo = TextEditingController(text: diario.titulo);
    cpDescricao = TextEditingController(text: diario.descricao);
    cpImagem = TextEditingController(text: diario.imagemUrl);

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
                                //Método chamado para atualizar os dados do diário editado no firebase.
                                editarService.atualizarDiario(diario.id, diario.uuid, cpTitulo.text, cpDescricao.text, cpImagem.text, diario.data);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Diário atualizado com sucesso!'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Não foi possível editar o diário!'),
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