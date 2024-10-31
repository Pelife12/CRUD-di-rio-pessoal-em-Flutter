import 'package:crud/model/diarioModel.dart';
import 'package:crud/service/cardService.dart';
import 'package:crud/view/editarView.dart';
import 'package:crud/view/homeView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDiario extends StatelessWidget {
  final DiarioModel diario;

  //Parâmetro obrigatórios que precisam ser utilizados na montagem do card.
  const CardDiario({
    super.key,
    required this.diario,
  });

  //Widget para adicionar o layout dos cards da aplicação.
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 66, 48, 46),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('dd/MM/yyyy').format(diario.data.toDate()),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.network(diario.imagemUrl),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              diario.titulo,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              diario.descricao,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditarView(diario: diario)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Editar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _dialogDeletar(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Deletar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Dialog para confirmação de exclusão do diário.
  Future<void> _dialogDeletar(BuildContext context) {
    CardService cardService = CardService();

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:  const Color.fromARGB(255, 246, 218, 171),
        title: const Text('Confirmação exclusão'),
        content: const Text(
          'Tem certeza que deseja deletar este diário?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey
            ),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Colors.red
            ),
            child: const Text(
              'Sim, deletar',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              try {
                //Método chamado para excluir o registro do firebase.
                cardService.deletarDiario(diario.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Diário deletado com sucesso!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível deletar o diário!'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      );
    });
  }
}