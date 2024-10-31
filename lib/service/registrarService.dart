import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RegistrarService  {

  //Método para adicionar as informações de uma novo diário cadastrado.
  void addDiario(String titulo, String descricao, String imagemUrl) async {
    Uuid uuid = const Uuid();
    await FirebaseFirestore.instance.collection('diario').add({
      'uuid': uuid.v4(),
      'titulo': titulo,
      'descricao': descricao,
      'data': DateTime.now(),
      'imagemUrl': imagemUrl,
    });
  }
}