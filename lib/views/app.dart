import 'package:flutter/material.dart';
import 'package:listinha_tarefas/views/edita.page.dart';
import 'package:listinha_tarefas/views/lista.page.dart';
import 'package:listinha_tarefas/views/nova.page.dart';


 class App extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     // Método responsável por desenhar a tela do aplicativo.
     return MaterialApp(
       debugShowCheckedModeBanner: false,
      //  home: ListaPage(),
      routes: {
        '/': (context) => ListaPage(),
        '/nova': (context) => NovaPage(), 
        '/edita': (context) => EditaPage(),
      },
      initialRoute: '/',
       );
     // o home vai indicar qual é a tela inicial da aplicação
   }
 }