import 'package:flutter/material.dart';

class InteresseAprendizagemPainel extends StatefulWidget {
  @override
  _InteresseAprendizagemPainelState createState() => _InteresseAprendizagemPainelState();
}

class _InteresseAprendizagemPainelState extends State<InteresseAprendizagemPainel> {
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
            Text("Painel interesse aprendizagem")
          ],
        ),
      ),
    );
  }

}