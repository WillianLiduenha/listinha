import 'package:listinha_tarefas/models/tarefa.model.dart';

class TarefaRepository {
  // ignore: deprecated_member_use
  // Ao usar a palavra estatica eu posso criar 10 listas e ela persiste durante o uso da aplicação (pior dos cenários)
  static List<Tarefa> tarefas = List<Tarefa>();

  TarefaRepository() {
    if (tarefas.isEmpty) {
      tarefas.add(Tarefa(id: "1", texto: "Lavar o carro", qtd: 15, finalizada: false));
      tarefas.add(Tarefa(id: "2", texto: "Comprar um", qtd: 16, finalizada: false));
      tarefas.add(Tarefa(id: "3", texto: "Comprar dois", qtd: 10, finalizada: false));
    }
  }

  void create(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  List<Tarefa> read() {
    return tarefas;
  }

  void delete(String texto) {
    final tarefa = tarefas.singleWhere((t) => t.texto == texto);
    tarefas.remove(tarefa);
  }

  void update(Tarefa newTarefa, Tarefa oldTarefa) {
    final tarefa = tarefas.singleWhere((t) => t.texto == oldTarefa.texto);
    tarefa.texto = newTarefa.texto;
  }
}
