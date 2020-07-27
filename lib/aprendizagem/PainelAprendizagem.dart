import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'Aprendizagem.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PainelAprendizagem extends StatefulWidget {
  @override
  int memberID;
  int interesseID;
  String username;
  PainelAprendizagem({this.memberID,this.username,this.interesseID});

  _PainelAprendizagemState createState() => _PainelAprendizagemState();
}

class _PainelAprendizagemState extends State<PainelAprendizagem> {
  TextEditingController _descricaoSimplificadaController = TextEditingController();
  TextEditingController _descricaoCompletaController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();
  List<Aprendizagem> l_interesses = List<Aprendizagem>();

  _exibirTelaCadastro({Aprendizagem interesse}){

    String titulo ="";
    if(interesse == null){//salvar
      _descricaoSimplificadaController.clear();
      _descricaoCompletaController.clear();
      _descricaoController.clear();
      titulo="Salvar";
    }else{//atualizar
      titulo="Atualizar";
      _descricaoController.text = interesse.descricao;

    }
    showDialog(

        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("${titulo} Aprendizado"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: _descricaoController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      //hintText: "Digite a descrição simplificada ..."
                    ),
                  ),


                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Cancelar")
              ),
              FlatButton(
                  onPressed: (){
                    //salvar
                    _salvarInteresse(interesse: interesse);
                  },
                  child: Text("Salvar")
              )
            ],
          );
        }
    );
  }
  Future<List<Aprendizagem>> recuperaInteresses() async{

    List<Aprendizagem> lista = List();
    String url_certa ="http://200.137.66.25:8080/api/aprendizagem/${widget.interesseID}";
    http.Response response2 = await http.get(url_certa);
    //print(response2);
    var dadosJson2 = json.decode(response2.body);
    for(var interesse in dadosJson2){
      //print(interesse["descricaoSimplificada"]);
    }

    List<Aprendizagem> interesses = List();
    for( var interesse in dadosJson2 ){
      Aprendizagem p = Aprendizagem(interesse["idAprendizagem"],widget.interesseID,interesse["descricao"],interesse["dataAprendizagem"]);
      interesses.add( p );

    }
    return interesses;
  }

  _salvarInteresse({Aprendizagem interesse}) async{
    String conteudo = _descricaoController.text;

    if(interesse == null){
      String url ="http://200.137.66.25:8080/api/aprendizagem/inserir";
      Map<String, dynamic> corpo = {'descricao':conteudo,'idInteresseAprendizagem': widget.interesseID.toString()};
      Navigator.pop(context);
      http.Response response = await http.post(url,body: corpo);
    }else{
      String url ="http://200.137.66.25:8080/api/aprendizagem/alterar";
      Map<String, dynamic> corpo = {'id': interesse.idAprendizagem.toString(),'descricao':conteudo};
      Navigator.pop(context);
      http.Response response = await http.post(url,body: corpo);
    }

    _descricaoSimplificadaController.clear();


    setState(() {});
  }

  _remove(Aprendizagem aprendizagem) async{
    String url ="http://200.137.66.25:8080/api/aprendizagem/apagar/${aprendizagem.idAprendizagem}";
    Navigator.pop(context);
    http.Response response = await http.get(url);
    setState(() {});
  }

  _removerInteresse(Aprendizagem interesse) async{
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Deseja remover este aprendizado ?"),
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
                    _remove(interesse);
                  },
                  child: Text("Sim")
              )
            ],
          );
        }
    );
  }

  _formatarData(String data){
    initializeDateFormatting("pt-BR");

    var formater = DateFormat.yMMMMd("pt-BR");
    DateTime dataConvertida =DateTime.parse(data);

    String dataFormatada = formater.format(dataConvertida);

    return dataFormatada;
  }





  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      appBar: AppBar(
        title: Text("Aprendizados"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<Aprendizagem>>(
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
              }else {

                print("lista: carregou!! ");
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){

                      List<Aprendizagem> lista = snapshot.data;

                      Aprendizagem post = lista[index];
                      return Card(

                        child: ListTile(
                          title: Text("Aprendizagem :"),
                          subtitle: Text(
                              "${post.descricao}",
                              textAlign: TextAlign.justify
                          ),

                          onTap: (){

                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  _exibirTelaCadastro(interesse: post);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  _removerInteresse(post);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
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

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            _exibirTelaCadastro();
          }
      ),
    );
  }

}