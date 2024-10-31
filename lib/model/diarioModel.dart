import 'package:cloud_firestore/cloud_firestore.dart';

//Model com todos os campos necessários para criar um diário.
class DiarioModel {
  final String id;
  final String uuid;
  final String titulo;
  final String descricao;
  final Timestamp data;
  final String imagemUrl;

  const DiarioModel({
    required this.id,
    required this.uuid,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.imagemUrl,
  });
}
