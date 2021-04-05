import 'dart:html';

import 'package:flutter/material.dart';
import 'package:listinha_tarefas/models/tarefa.model.dart';
import 'package:listinha_tarefas/repositories/tarefa.repository.dart';

class EditaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();

  onSave(BuildContext context, Tarefa tarefas) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // submit do form do HTML
      _repository.update(_tarefa, tarefas);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edita tarefa"),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text(
              "Salvar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => onSave(context, tarefa),
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
                initialValue: tarefa.texto,
                decoration: InputDecoration(
                  labelText: "Nome do produto",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _tarefa.texto = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
              TextFormField(
                initialValue: tarefa.qtd.toString(),
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
                initialValue: tarefa.valor.toString(),
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
                initialValue: tarefa.descricao,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Descrição ou Nota",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _tarefa.descricao = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
