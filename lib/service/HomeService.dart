import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService  {

  //Método para buscar todos os registros cadastrados no firebase
  Future<QuerySnapshot<Map<String, dynamic>>> getTodosDiarios() async {
     return await FirebaseFirestore.instance.collection('diario').get();
  }
}