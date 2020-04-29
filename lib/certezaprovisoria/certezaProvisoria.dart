class CertezaProvisoria{

  int _idInteresseAprendizagem;
  int _idCertezaProvisoria ;
  String _certeza;

  CertezaProvisoria(this._idInteresseAprendizagem, this._idCertezaProvisoria,
      this._certeza);

  String get certeza => _certeza;

  set certeza(String value) {
    _certeza = value;
  }

  int get idCertezaProvisoria => _idCertezaProvisoria;

  set idCertezaProvisoria(int value) {
    _idCertezaProvisoria = value;
  }

  int get idInteresseAprendizagem => _idInteresseAprendizagem;

  set idInteresseAprendizagem(int value) {
    _idInteresseAprendizagem = value;
  }


}