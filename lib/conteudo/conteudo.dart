class Conteudo{


  int _idConteudo ;
  String _conteudo;
  String _dataInsercao;
  String _linkArquivo;
  String _origem;
  int _idInteresseAprendizagem;
  int _idTipoConteudo;

  Conteudo(this._idConteudo, this._conteudo, this._dataInsercao,
      this._linkArquivo, this._origem, this._idInteresseAprendizagem,
      this._idTipoConteudo);

  int get idTipoConteudo => _idTipoConteudo;

  set idTipoConteudo(int value) {
    _idTipoConteudo = value;
  }

  int get idInteresseAprendizagem => _idInteresseAprendizagem;

  set idInteresseAprendizagem(int value) {
    _idInteresseAprendizagem = value;
  }

  String get origem => _origem;

  set origem(String value) {
    _origem = value;
  }

  String get linkArquivo => _linkArquivo;

  set linkArquivo(String value) {
    _linkArquivo = value;
  }

  String get dataInsercao => _dataInsercao;

  set dataInsercao(String value) {
    _dataInsercao = value;
  }

  String get conteudo => _conteudo;

  set conteudo(String value) {
    _conteudo = value;
  }

  int get idConteudo => _idConteudo;

  set idConteudo(int value) {
    _idConteudo = value;
  }


}