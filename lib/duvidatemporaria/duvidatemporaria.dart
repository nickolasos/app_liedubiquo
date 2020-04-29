class DuvidaTemporaria{

  int _idInteresseAprendizagem;
  int _idDuvidaTemporaria ;
  String _duvida;

  DuvidaTemporaria(this._idInteresseAprendizagem, this._idDuvidaTemporaria,
      this._duvida);

  String get duvida => _duvida;

  set duvida(String value) {
    _duvida = value;
  }

  int get idDuvidaTemporaria => _idDuvidaTemporaria;

  set idDuvidaTemporaria(int value) {
    _idDuvidaTemporaria = value;
  }

  int get idInteresseAprendizagem => _idInteresseAprendizagem;

  set idInteresseAprendizagem(int value) {
    _idInteresseAprendizagem = value;
  }


}