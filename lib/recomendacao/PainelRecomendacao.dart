import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'recomendacao.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'EditarRecomendacao.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class PainelRecomendacao extends StatefulWidget {
  @override
  int memberID;
  int interesseID;
  String username;
  PainelRecomendacao({this.memberID,this.username,this.interesseID});

  _PainelRecomendacaoState createState() => _PainelRecomendacaoState();
}



class _PainelRecomendacaoState extends State<PainelRecomendacao> {
  TextEditingController _descricaoController = TextEditingController();
  List<Recomendacao> l_interesses = List<Recomendacao>();

  Future<List<Recomendacao>> recuperaInteresses() async{
    //print("nicksdfsdf  :");
    //print(widget.interesseID);
    List<Recomendacao> lista = List();
    String url_certa ="http://200.137.66.25:8080/api/recomendacao/${widget.interesseID}";
    http.Response response2 = await http.get(url_certa);
    //print(response2);
    var dadosJson2 = json.decode(response2.body);
    for(var interesse in dadosJson2){
      //print(interesse["idTipoRecomendacao"].toString());
      //print(interesse["descricao"]);
    }

    List<Recomendacao> recomendacoes = List();
    //if(dadosJson2 != null){
      for( var recomendacao in dadosJson2 ){

        //Recomendacao p = Recomendacao(recomendacao["idRecomendacao"],recomendacao["dataRecomendacao"],'12',recomendacao["idTipoRecomendacao"].toString(),
        //    '1',recomendacao["idRecomendado"],1,'rewrewre');


        Recomendacao p = Recomendacao(recomendacao["idRecomendacao"],recomendacao["dataRecomendacao"],recomendacao["pontuacao"],recomendacao["idTipoRecomendacao"].toString(),
            recomendacao["idRecomendador"].toString(),recomendacao["idRecomendado"],recomendacao["idInteresseAprendizagem"],recomendacao["descricao"]);

        recomendacoes.add( p );

        print(p);
      }
    //}

    return recomendacoes;
  }

  _formatarData(String data){
    initializeDateFormatting("pt-BR");

    //var formater = DateFormat("dd/MM/y H:m:s");
    var formater = DateFormat.yMMMMd("pt-BR");
    DateTime dataConvertida =DateTime.parse(data);

    String dataFormatada = formater.format(dataConvertida);

    return dataFormatada;
  }

  _trataPontuacao(String pontuacao){
    if(pontuacao == null){
      return "Avaliar !";
    }else{
      return pontuacao ;
    }

  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Recomendações"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<Recomendacao>>(
        future: recuperaInteresses(),
        builder: (context, snapshot){

          switch( snapshot.connectionState ){
            case ConnectionState.none :
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active :
            case ConnectionState.done :
              if( snapshot.hasError ){
                print("lista: Erro ao carregar ");
                return Scaffold(
                );
              }else {

                print("lista: carregou!! ");
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){

                      List<Recomendacao> lista = snapshot.data;

                      Recomendacao post = lista[index];
                      return Card(

                        child: ListTile(
                          title: Text("Recomendação :"),

                          subtitle: Html(
                              data:"${post.descricao}",
                              onLinkTap: (link) async{
                                await launch(link);
                              },


                          ),



                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditarRecomendacao(idRecomendacao:post.idRecomendacao)
                                      )
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),

                                ),

                              ),
                              Text(
                                  _trataPontuacao(post.pontuacao)
                              )
                            ],
                          ),

                        ),

                      );

                    }
                );

              }
              break;
          }

        },
      ),


    );
  }

}