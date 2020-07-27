class Recomendacao{
  int _idRecomendacao ;
  String _dataRecomendacao;
  String _pontuacao;
  String _idTipoRecomendacao;
  String _idRecomendador;
  int _idRecomendado;
  int _idInteresseAprendizagem;
  String _descricao;

  Recomendacao(this._idRecomendacao, this._dataRecomendacao, this._pontuacao,
      this._idTipoRecomendacao, this._idRecomendador, this._idRecomendado,
      this._idInteresseAprendizagem, this._descricao);

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  int get idInteresseAprendizagem => _idInteresseAprendizagem;

  set idInteresseAprendizagem(int value) {
    _idInteresseAprendizagem = value;
  }

  int get idRecomendado => _idRecomendado;

  set idRecomendado(int value) {
    _idRecomendado = value;
  }

  String get idRecomendador => _idRecomendador;

  set idRecomendador(String value) {
    _idRecomendador = value;
  }

  String get idTipoRecomendacao => _idTipoRecomendacao;

  set idTipoRecomendacao(String value) {
    _idTipoRecomendacao = value;
  }

  String get pontuacao => _pontuacao;

  set pontuacao(String value) {
    _pontuacao = value;
  }

  String get dataRecomendacao => _dataRecomendacao;

  set dataRecomendacao(String value) {
    _dataRecomendacao = value;
  }

  int get idRecomendacao => _idRecomendacao;

  set idRecomendacao(int value) {
    _idRecomendacao = value;
  }


}