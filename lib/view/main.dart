import 'package:crud/service/firebase_options.dart';
import 'package:crud/view/homeView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/*
Diário Pessoal: Registrar entradas diárias com título e descrição dos acontecimentos do dia.
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    title: "Flutter App",
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}