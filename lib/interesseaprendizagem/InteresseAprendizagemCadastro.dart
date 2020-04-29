import 'package:flutter/material.dart';

class InteresseAprendizagemCadastro extends StatefulWidget {
  @override
  _InteresseAprendizagemCadastroState createState() => _InteresseAprendizagemCadastroState();
}

class _InteresseAprendizagemCadastroState extends State<InteresseAprendizagemCadastro> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text("Cadastro interesse aprendizagem")
          ],
        ),
      ),
    );
  }

}