class Aprendizagem {

  int _idAprendizagem;
  int _idInteresseAprendizagem ;
  String _descricao;
  String _dataAprendizagem;

  Aprendizagem(this._idAprendizagem, this._idInteresseAprendizagem,
      this._descricao, this._dataAprendizagem);

  String get dataAprendizagem => _dataAprendizagem;

  set dataAprendizagem(String value) {
    _dataAprendizagem = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  int get idInteresseAprendizagem => _idInteresseAprendizagem;

  set idInteresseAprendizagem(int value) {
    _idInteresseAprendizagem = value;
  }

  int get idAprendizagem => _idAprendizagem;

  set idAprendizagem(int value) {
    _idAprendizagem = value;
  }


}