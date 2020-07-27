import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'interesseaprendizagem/InteresseAprendizagem.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'PainelSecundario.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Painel extends StatefulWidget {
  @override
  int memberID;
  String username;
  Painel({this.memberID,this.username});

  _PainelState createState() => _PainelState();
}

class _PainelState extends State<Painel> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false ;
  bool _isListening = false ;
  String resultText ="";


  @override
  void initState(){
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

    TextEditingController _descricaoSimplificadaController = TextEditingController();
    TextEditingController _descricaoCompletaController = TextEditingController();
    TextEditingController _conteudoDescritivoController = TextEditingController();
    List<InteresseAprendizagem> l_interesses = List<InteresseAprendizagem>();

    _exibirTelaConteudoDescritivoCadastro({InteresseAprendizagem interesse}){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(

              title: Text("Inserir conteudo descritivo"),
              content: SingleChildScrollView(
                child: Column(

                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                  TextField(


                  controller: _conteudoDescritivoController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Conteudo :",

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
            _salvarConteudoDescritivo(interesse: interesse);
            },
            child: Text("Salvar")
            ),
            /*
              FloatingActionButton(
                child: Icon(Icons.mic),
                onPressed: (){},
                //mini: true,
                backgroundColor: Colors.lightBlue,
              ),
              */

            ],
            );
          }
      );
    }

  _exibirTelaCadastro({InteresseAprendizagem interesse}){

    String titulo ="";
    if(interesse == null){//salvar
      _descricaoSimplificadaController.clear();
      _descricaoCompletaController.clear();
      titulo="Salvar";
    }else{//atualizar
      titulo="Atualizar";
      _descricaoSimplificadaController.text =interesse.descricaoSimplificada;
      _descricaoCompletaController.text = interesse.descricaoCompleta;
    }
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(

            title: Text("${titulo} interesse"),
          content: SingleChildScrollView(
          child: Column(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                TextField(


                  controller: _descricaoSimplificadaController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Descrição simplificada",
                    //hintText: "Digite a descrição simplificada ..."

                  ),

                ),


                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: _descricaoCompletaController,
                  decoration: InputDecoration(
                      labelText: "Descrição completa",


                      //hintText: "Digite a descrição completa ..."
                  ),
                )
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
              ),
              /*
              FloatingActionButton(
                child: Icon(Icons.mic),
                onPressed: (){},
                //mini: true,
                backgroundColor: Colors.lightBlue,
              ),
              */

            ],
          );
        }
    );
  }
    Future<List<InteresseAprendizagem>> recuperaInteresses() async{

      List<InteresseAprendizagem> lista = List();
      String url_certa ="http://200.137.66.25:8080/api/interesse/${widget.memberID}";
      http.Response response2 = await http.get(url_certa);
      //print(response2);
      var dadosJson2 = json.decode(response2.body);
      for(var interesse in dadosJson2){
        //print(interesse["descricaoSimplificada"]);
      }

      List<InteresseAprendizagem> interesses = List();
      for( var interesse in dadosJson2 ){
        InteresseAprendizagem p = InteresseAprendizagem(interesse["idInteresseAprendizagem"], interesse["idPessoa"],
            interesse["descricaoSimplificada"],interesse["descricaoCompleta"],interesse["dataCriacao"]);
        interesses.add( p );
        //print(p);
      }
      return interesses;
    }

    _salvarInteresse({InteresseAprendizagem interesse}) async{
      String descricaoSimplificada = _descricaoSimplificadaController.text;
      String descricaoCompleta = _descricaoCompletaController.text;
      String idPessoa = widget.memberID.toString();
      if(interesse == null){
        String url ="http://200.137.66.25:8080/api/interesse/inserir";
        Map<String, dynamic> corpo = {'idPessoa': idPessoa,'descricaoSimplificada': descricaoSimplificada,'descricaoCompleta':descricaoCompleta};

        http.Response response = await http.post(url,body: corpo);
        //print(idPessoa);
      }else{
        String url ="http://200.137.66.25:8080/api/interesse/alterar";
        Map<String, dynamic> corpo = {'id': interesse.idInteresseAprendizagem.toString(),'descricaoSimplificada': descricaoSimplificada,'descricaoCompleta':descricaoCompleta};

        http.Response response = await http.post(url,body: corpo);
      }





      _descricaoSimplificadaController.clear();
      _descricaoCompletaController.clear();

     Navigator.pop(context);
     setState(() {});
    }

  _salvarConteudoDescritivo({InteresseAprendizagem interesse}) async{
    String conteudo = _conteudoDescritivoController.text;
    String origem = "conteudo descritivo";
    String link="";

    String url ="http://200.137.66.25:8080/api/conteudo/inserir";
    Map<String, dynamic> corpo = {'conteudo':conteudo,'linkArquivo':link,
      'origem':origem,'idInteresseAprendizagem': interesse.idInteresseAprendizagem.toString(),'idConteudoDescritivo':'1'};

    http.Response response = await http.post(url,body: corpo);

    Navigator.pop(context);
    setState(() {});
  }

    _remove(InteresseAprendizagem interesse) async{
      String url ="http://200.137.66.25:8080/api/interesse/apagar/${interesse.idInteresseAprendizagem}";
      //print(interesse.idInteresseAprendizagem);
      http.Response response = await http.get(url);
      Navigator.pop(context);
      setState(() {});

    }
    _removerInteresse(InteresseAprendizagem interesse) async{

      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Deseja remover este interesse de aprendizagem ?"),
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
        title: Text("Interesses de aprendizagem"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<InteresseAprendizagem>>(
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
                //print("lista: Erro ao carregar ");
              }else {

                //print("lista: carregou!! ");
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){

                      List<InteresseAprendizagem> lista = snapshot.data;

                      InteresseAprendizagem post = lista[index];
                      final i = lista[index];
                      //print(post.descricaoSimplificada);
                      return Card(

                        child: ListTile(
                          title: Text("${_formatarData(post.dataCriacao)} - ${post.descricaoSimplificada}"),
                          subtitle: Text("${post.descricaoCompleta}"),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PainelSecundario(memberID:widget.memberID,username:widget.username,interesseID: post.idInteresseAprendizagem)
                                )
                            );
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
                                  _exibirTelaConteudoDescritivoCadastro(interesse: post);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.blue,
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