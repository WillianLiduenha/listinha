class Tarefa {
  // Atributos da classe:
  String id;
  String texto;
  int qtd;
  double valor;
  bool finalizada;
  bool ativo;
  String descricao;
  // Contrutor:
  Tarefa({
    this.id,
    this.texto,
    this.qtd,
    this.valor,
    this.finalizada = false,
    this.ativo = true,
    this.descricao,
  });
}
