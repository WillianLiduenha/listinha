import 'dart:html';

import 'package:flutter/material.dart';
import 'package:listinha_tarefas/models/tarefa.model.dart';
import 'package:listinha_tarefas/repositories/tarefa.repository.dart';

class NovaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // submit do form do HTML
      _repository.create(_tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova tarefa"),
        centerTitle: false,
        actions: [
          TextButton(
            child: Text(
              "Salvar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => onSave(context),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Card(
            child: Column(children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Nome do produto",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _tarefa.texto = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Quantidade do item",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _tarefa.qtd = int.parse(value),
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço unitário",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _tarefa.valor = double.parse(value),
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                maxLength: 100,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Descrição ou Nota",
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(20),
                ),
                onSaved: (value) => _tarefa.descricao = value,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
