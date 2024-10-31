import 'package:cloud_firestore/cloud_firestore.dart';

class EditarService {

  //Método para atualizar os dados editados no firebase.
  void atualizarDiario(String id, String uuid, String titulo, String descricao, String imagemUrl, Timestamp data) async {
    await FirebaseFirestore.instance.collection('diario').doc(id).set({
      'titulo': titulo,
      'descricao': descricao,
      'uuid': uuid,
      'data': data,
      'imagemUrl': imagemUrl,
    });
  }
}