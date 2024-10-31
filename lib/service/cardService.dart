import 'package:cloud_firestore/cloud_firestore.dart';

class CardService {

  //Método para deletar o registro do firebase.
  void deletarDiario(String id) async {
    await FirebaseFirestore.instance.collection('diario').doc(id).delete();
  }
}