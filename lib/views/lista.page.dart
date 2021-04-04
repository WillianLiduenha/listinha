import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listinha_tarefas/models/tarefa.model.dart';
import 'package:listinha_tarefas/repositories/tarefa.repository.dart';
import 'package:listinha_tarefas/views/nova.page.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repository = TarefaRepository();

  List<Tarefa> tarefas;

  initState() {
    super.initState();
    this.tarefas = repository.read();
  }

  Future<void> adicionarTarefa(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    setState(() {
      if (result != null && result == true) {
        this.tarefas = repository.read();
        ordenar(tarefas);
      }
    });
  }

  Future<bool> confirmarExclusao(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirma a exclusão?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  Future<void> editarTarefas(BuildContext context, Tarefa tarefa) async {
    {
      var result = await Navigator.of(context).pushNamed(
        '/edita',
        arguments: tarefa,
      );
      setState(() {
        if (result != null && result == true) {
          this.tarefas = repository.read();
          ordenar(tarefas);
        }
      });
    }
  }

  double total(List<Tarefa> tarefas) {
    double totalzin = 0;
    tarefas.forEach((element) {
      totalzin += element.valor;
    });
    return totalzin;
  }

  bool canEdit = false;

  void ordenar(List<Tarefa> tarefa) {
    tarefa.sort((a, b) => b.ativo ? 1 : -1);
    tarefa.sort((a, b) {
      if (!a.ativo) {
        return -1;
      }

      //Ex.: Após a ordenação
      // if (a.finalizada) {
      //   return 1;
      // }
      // return -1;

      return a.finalizada ? 1 : -1; // EX.: ternário
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total do Carrinho: " + total(tarefas).toString()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => setState(() => canEdit = !canEdit),
              icon: Icon(Icons.edit)),
        ],
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, indice) {
          var tarefa = tarefas[indice];
          return Card(
            color: tarefa.ativo ? Colors.white : Colors.red,
            child: Dismissible(
              key: Key(tarefas[indice].texto),
              background: Container(
                  color: Colors.red, child: Center(child: Text("Apagar"))),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  repository.delete(tarefa.texto);
                  // setState(() => this.tarefas = repository.read());    //pior caso
                  ordenar(tarefas);
                  setState(() => this.tarefas.remove(tarefa));
                } else if (direction == DismissDirection.endToStart) {
                  //Invoca a tela de atualizar
                }
              },
              confirmDismiss: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  return confirmarExclusao(context);
                }
              },
              child: CheckboxListTile(
                title: Row(
                  children: [
                    canEdit
                        ? Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => editarTarefas(context, tarefa),
                              ),
                              IconButton(
                                icon: Icon(Icons.adjust_rounded),
                                onPressed: () {
                                  return !tarefas[indice].finalizada
                                      ? setState(() {
                                          tarefas[indice].ativo =
                                              !tarefas[indice].ativo;
                                          ordenar(tarefas);
                                        })
                                      : Container();
                                },
                              ),
                            ],
                          )
                        : Container(),
                    Column(
                      children: [
                        Text(
                          tarefas[indice].texto,
                          style: TextStyle(
                            decoration: tarefas[indice].finalizada
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Quantidade: " + tarefas[indice].qtd.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                decoration: tarefas[indice].finalizada
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            Text(
                              "Preço: " +
                                  tarefas[indice].valor.toString() +
                                  " reais.",
                              style: TextStyle(
                                fontSize: 10,
                                decoration: tarefas[indice].finalizada
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                value: tarefas[indice].finalizada,
                onChanged: (value) {
                  return tarefas[indice].ativo
                      ? setState(() {
                          tarefas[indice].finalizada = value;
                          ordenar(tarefas);
                        })
                      : Container();
                },
              ),
            ),
          );
        },
      ), // criar a lista com os dados do read();
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => adicionarTarefa(context),
      ),
    );
  }
}
