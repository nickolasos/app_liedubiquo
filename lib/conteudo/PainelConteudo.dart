import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'conteudo.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PainelConteudo extends StatefulWidget {
  @override
  int memberID;
  int interesseID;
  String username;
  PainelConteudo({this.memberID,this.username,this.interesseID});

  _PainelConteudoState createState() => _PainelConteudoState();
}

class _PainelConteudoState extends State<PainelConteudo> {
  TextEditingController _descricaoSimplificadaController = TextEditingController();
  TextEditingController _descricaoCompletaController = TextEditingController();

  TextEditingController _conteudoController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _origemController = TextEditingController();
  List<Conteudo> l_interesses = List<Conteudo>();

  _exibirTelaCadastro({Conteudo interesse}){

    String titulo ="";
    if(interesse == null){//salvar
      _descricaoSimplificadaController.clear();
      _descricaoCompletaController.clear();
      _conteudoController.clear();
      _linkController.clear();
      _origemController.clear();
      titulo="Salvar";
    }else{//atualizar
      titulo="Atualizar";
      _conteudoController.text = interesse.conteudo;
      _linkController.text = interesse.linkArquivo;
      _origemController.text =interesse.origem;
    }
    showDialog(

        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("${titulo} Conteúdo"),
            content: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: _conteudoController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Conteúdo",
                    //hintText: "Digite a descrição simplificada ..."
                  ),
                ),
                TextField(
                  controller: _linkController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Link",
                    //hintText: "Digite a descrição simplificada ..."
                  ),
                ),
                TextField(
                  controller: _origemController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Origem",
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
  Future<List<Conteudo>> recuperaInteresses() async{

    List<Conteudo> lista = List();
    String url_certa ="http://apipg.ddns.net/api/conteudo/${widget.interesseID}";
    http.Response response2 = await http.get(url_certa);
    //print(response2);
    var dadosJson2 = json.decode(response2.body);
    for(var interesse in dadosJson2){
      //print(interesse["descricaoSimplificada"]);
    }

    List<Conteudo> interesses = List();
    for( var interesse in dadosJson2 ){
      Conteudo p = Conteudo(interesse["idConteudo"],interesse["conteudo"],interesse["dataInsercao"],
          interesse["linkArquivo"],interesse["origem"],widget.interesseID,);
      interesses.add( p );

    }
    return interesses;
  }

  _salvarInteresse({Conteudo interesse}) async{
    String conteudo = _conteudoController.text;
    String link = _linkController.text;
    String origem = _origemController.text;

    if(interesse == null){
      String url ="http://apipg.ddns.net/api/conteudo/inserir";
      Map<String, dynamic> corpo = {'conteudo':conteudo,'linkArquivo':link,
        'origem':origem,'idInteresseAprendizagem': widget.interesseID.toString()};
      Navigator.pop(context);
      http.Response response = await http.post(url,body: corpo);
    }else{
      String url ="http://apipg.ddns.net/api/conteudo/alterar";
      Map<String, dynamic> corpo = {'id': interesse.idConteudo.toString(),'conteudo':conteudo,'linkArquivo':link,
        'origem':origem};
      Navigator.pop(context);
      http.Response response = await http.post(url,body: corpo);
    }

    _descricaoSimplificadaController.clear();


    setState(() {});
  }

  _remove(Conteudo conteudo) async{
    String url ="http://apipg.ddns.net/api/conteudo/apagar/${conteudo.idConteudo}";
    Navigator.pop(context);
    http.Response response = await http.get(url);
    setState(() {});
  }

  _removerInteresse(Conteudo interesse) async{
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Deseja remover este conteúdo ?"),
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
        title: Text("Conteúdos"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<Conteudo>>(
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

                      List<Conteudo> lista = snapshot.data;

                      Conteudo post = lista[index];
                      return Card(

                        child: ListTile(
                          title: Text("Conteudo :"),
                          subtitle: Text(
                              "${post.conteudo} \nLink:\n${post.linkArquivo}\nOrigem:${post.origem}",
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