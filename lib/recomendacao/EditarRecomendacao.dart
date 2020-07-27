import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'recomendacao.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:speech_recognition/speech_recognition.dart';
class EditarRecomendacao extends StatefulWidget {
  @override
  int idRecomendacao;

  EditarRecomendacao({this.idRecomendacao});

  _EditarRecomendacaoState createState() => _EditarRecomendacaoState();
}

class _EditarRecomendacaoState extends State<EditarRecomendacao> {
  TextEditingController _descricaoController = TextEditingController();
  List<Recomendacao> l_interesses = List<Recomendacao>();

_pontuar(int pontuacao) async{
  String url ="http://200.137.66.25:8080/api/recomendacao/alterar";
  Map<String, dynamic> corpo = {'idRecomendacao': widget.idRecomendacao.toString(),'pontuacao':pontuacao.toString()};
  http.Response response = await http.post(url,body: corpo);
  Navigator.pop(context);
  Navigator.pop(context);
}
 _darNota(int pontuacao) async{


   showDialog(
       context: context,
       builder: (context){
         return AlertDialog(
           title: Text("Deseja atribuir nota ${pontuacao} a esta recomendação ?"),
           content: SingleChildScrollView(
             child: Column(
               mainAxisSize: MainAxisSize.min,
             ),
           ),
           actions: <Widget>[
             FlatButton(
                 onPressed: ()=>Navigator.pop(context),
                 child: Text("Não")
             ),
             FlatButton(
                 onPressed: (){
                   //salvar
                   _pontuar(pontuacao);
                 },
                 child: Text("Sim")
             )
           ],
         );
       }
   );


 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Avaliar Recomendação"),
          backgroundColor: Colors.lightBlue,
        ),
        body:Container(
          //decoration: BoxDecoration(color: Color(0xffC0C0C0)),
          decoration: BoxDecoration(color: Colors.white),
          /*
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("imagens/fundo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          */
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Avalie esta recomendação ",
                  style: TextStyle(
                    fontSize: 20,

                  ),
                ),
              )

                  ),

                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          _darNota(1);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 40,

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _darNota(2);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _darNota(3);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _darNota(4);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _darNota(5);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

}