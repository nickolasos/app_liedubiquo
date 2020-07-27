import 'package:flutter/material.dart';
import 'duvidatemporaria/PainelDuvida.dart';
import 'certezaprovisoria/PainelCerteza.dart';
import 'conteudo/PainelConteudo.dart';
import 'aprendizagem/PainelAprendizagem.dart';
import 'recomendacao/PainelRecomendacao.dart';
class PainelSecundario extends StatefulWidget {
  @override
  int memberID;
  int interesseID;
  String username;
  PainelSecundario({this.memberID,this.username,this.interesseID});
  _PainelSecundarioState createState() => _PainelSecundarioState();
}

class _PainelSecundarioState extends State<PainelSecundario> {

  void _abrirDuvidaTemporaria(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PainelDuvida(memberID:widget.memberID,username:widget.username,interesseID: widget.interesseID)
        )
    );
  }
  void _abrirConteudo(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PainelConteudo(memberID:widget.memberID,username:widget.username,interesseID: widget.interesseID)
        )
    );
  }
  void _abrirCertezaProvisoria(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PainelCerteza(memberID:widget.memberID,username:widget.username,interesseID: widget.interesseID)
        )
    );
  }
  void _abrirRecomendacao(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PainelRecomendacao(memberID:widget.memberID,username:widget.username,interesseID: widget.interesseID)
        )
    );
  }

  void _abrirAprendizagem(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PainelAprendizagem(memberID:widget.memberID,username:widget.username,interesseID: widget.interesseID)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Gerenciar conhecimento"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: BoxDecoration(
         // image: DecorationImage(
           // image: AssetImage("imagens/fundo.jpg"),
            //fit: BoxFit.cover,
          //),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Image.asset("imagens/logo.png"),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: _abrirDuvidaTemporaria,
                    child: Image.asset("imagens/duvida_temporaria.png",width: 120,
                      height: 100,


                    ),
                  ),
                  GestureDetector(
                    onTap: _abrirConteudo,
                    child: Image.asset("imagens/conteudo.png",width: 120,
                      height: 100,

                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: _abrirCertezaProvisoria,
                    child: Image.asset("imagens/certeza_provisoria.png",width: 120,
                      height: 100,

                    ),
                  ),
                  GestureDetector(
                    onTap: _abrirRecomendacao,
                    child: Image.asset("imagens/recomendacao.png",width: 120,
                      height: 100,

                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: _abrirAprendizagem,
                    child: Image.asset("imagens/aprendizagem.png",width: 120,
                      height: 100,

                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}