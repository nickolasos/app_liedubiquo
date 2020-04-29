class InteresseAprendizagem{

  int _idInteresseAprendizagem;
  int _idPessoa ;
  String _descricaoSimplificada;
  String _descricaoCompleta;
  String _dataCriacao;

  InteresseAprendizagem(this._idInteresseAprendizagem, this._idPessoa,
      this._descricaoSimplificada, this._descricaoCompleta, this._dataCriacao);

  String get dataCriacao => _dataCriacao;

  set dataCriacao(String value) {
    _dataCriacao = value;
  }

  String get descricaoCompleta => _descricaoCompleta;

  set descricaoCompleta(String value) {
    _descricaoCompleta = value;
  }

  String get descricaoSimplificada => _descricaoSimplificada;

  set descricaoSimplificada(String value) {
    _descricaoSimplificada = value;
  }

  int get idPessoa => _idPessoa;

  set idPessoa(int value) {
    _idPessoa = value;
  }

  int get idInteresseAprendizagem => _idInteresseAprendizagem;

  set idInteresseAprendizagem(int value) {
    _idInteresseAprendizagem = value;
  }


}