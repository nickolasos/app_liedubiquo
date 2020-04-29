import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'duvidatemporaria.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PainelDuvida extends StatefulWidget {
  @override
  int memberID;
  int interesseID;
  String username;
  PainelDuvida({this.memberID,this.username,this.interesseID});

  _PainelDuvidaState createState() => _PainelDuvidaState();
}

class _PainelDuvidaState extends State<PainelDuvida> {


  TextEditingController _descricaoSimplificadaController = TextEditingController();
  TextEditingController _descricaoCompletaController = TextEditingController();
  List<DuvidaTemporaria> l_interesses = List<DuvidaTemporaria>();

  _exibirTelaCadastro({DuvidaTemporaria interesse}){

    String titulo ="";
    if(interesse == null){//salvar
      _descricaoSimplificadaController.clear();
      _descricaoCompletaController.clear();
      titulo="Salvar";
    }else{//atualizar
      titulo="Atualizar";
      _descricaoSimplificadaController.text =interesse.duvida;
    }
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("${titulo} Dúvida temporária"),
          content: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: _descricaoSimplificadaController,
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
  Future<List<DuvidaTemporaria>> recuperaInteresses() async{

    List<DuvidaTemporaria> lista = List();
    String url_certa ="http://apipg.ddns.net/api/duvida/${widget.interesseID}";
    http.Response response2 = await http.get(url_certa);
    //print(response2);
    var dadosJson2 = json.decode(response2.body);
    for(var interesse in dadosJson2){
      //print(interesse["descricaoSimplificada"]);
    }

    List<DuvidaTemporaria> interesses = List();
    for( var interesse in dadosJson2 ){
      DuvidaTemporaria p = DuvidaTemporaria(widget.interesseID,interesse["idDuvidaTemporaria"],interesse["duvida"]);
      interesses.add( p );
      //print(p);
    }
    return interesses;
  }

  _salvarInteresse({DuvidaTemporaria interesse}) async{
    String duvida = _descricaoSimplificadaController.text;
    String idPessoa = widget.memberID.toString();
    if(interesse == null){
      String url ="http://apipg.ddns.net/api/duvida/inserir";
      Map<String, dynamic> corpo = {'idInteresseAprendizagem': widget.interesseID.toString(),'duvida':duvida};
      Navigator.pop(context);
      http.Response response = await http.post(url,body: corpo);
    }else{
      String url ="http://apipg.ddns.net/api/duvida/alterar";
      Map<String, dynamic> corpo = {'id': interesse.idDuvidaTemporaria.toString(),'duvida':duvida};
      Navigator.pop(context);
      http.Response response = await http.post(url,body: corpo);
    }


    _descricaoSimplificadaController.clear();


    setState(() {});
  }
  _remove(DuvidaTemporaria duvida) async{
    String url ="http://apipg.ddns.net/api/duvida/apagar/${duvida.idDuvidaTemporaria}";
    Navigator.pop(context);
    http.Response response = await http.get(url);
    setState(() {});
  }

  _removerInteresse(DuvidaTemporaria interesse) async{
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Deseja remover esta dúvida temporária ?"),
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

    //var formater = DateFormat("dd/MM/y H:m:s");
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
        title: Text("Dúvidas temporárias"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<DuvidaTemporaria>>(
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

                      List<DuvidaTemporaria> lista = snapshot.data;

                      DuvidaTemporaria post = lista[index];
                      return Card(

                        child: ListTile(
                          title: Text("Dúvida :"),
                          subtitle: Text("${post.duvida}"),
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