class Tarefa {
  // Atributos da classe:
  String id;
  String texto;
  int qtd;
  bool finalizada;
  bool ativo;
  // Contrutor:
  Tarefa(
      {this.id,
      this.texto,
      this.qtd,
      this.finalizada = false,
      this.ativo = true});
}
