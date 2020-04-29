import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Post.dart';
import 'InteresseAprendizagem.dart';
import 'package:speech_recognition/speech_recognition.dart';


class InteresseAprendizagemLista extends StatefulWidget {
  @override
  _InteresseAprendizagemListaState createState() => _InteresseAprendizagemListaState();
}

class _InteresseAprendizagemListaState extends State<InteresseAprendizagemLista> {
  List _itens = [];

  SpeechRecognition _speechRecognition;
  bool _isAvalable = false ;
  bool _isListening = false ;
  String resultText ="";


  @override
  void initState(){
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer(){
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
        (bool result) =>setState(()=>_isAvalable = result)
    );
    _speechRecognition.setRecognitionStartedHandler(
        () =>setState(()=>_isListening = true)
    );
    _speechRecognition.setRecognitionResultHandler(
            (String speech) =>setState(()=>resultText = speech)
    );
    _speechRecognition.setRecognitionCompleteHandler(
            () =>setState(()=>_isListening = false)
    );
    _speechRecognition.activate().then(
            (result) =>setState(()=>_isAvalable = result)
    );
  }


  void _carregarItens(){
    for(int i=0; i<=10;i++){
      Map<String, dynamic> item = Map();
      item["titulo"]="Título ${i} fsdfsdfsdfsdf";
      item["descricao"]="Descricao ${i} yrtyrtbfg";
      _itens.add(item);
    }
  }

  Future<List<InteresseAprendizagem>> _recuperaInteresses() async{

    List<InteresseAprendizagem> lista = List();
    String url_certa ="http://apipg.ddns.net/api/interesseaprendizagem";
    String url ="https://jsonplaceholder.typicode.com/posts";
    print("nickolas");
    http.Response response = await http.get(url);
    http.Response response2 = await http.get(url_certa);
    print(response2);
    var dadosJson = json.decode(response.body);
    var dadosJson2 = json.decode(response2.body);
    print("nickolas1");
    for(var interesse in dadosJson2){
      print(interesse["descricaoSimplificada"]);
    }
    /*
    for(var post in dadosJson){

      print(post["descricaoSimplicada"]);
      InteresseAprendizagem a = InteresseAprendizagem(post["idInteresseAprendizagem"], post["idPessoa"], post["descricaoSimplicada"], post["descricaoCompleta"], post["dataCriacao"]);
      lista.add(a);
    }
    //return json.decode(response.body);
    print(lista.toString());
    return lista;
    */

    List<InteresseAprendizagem> interesses = List();
    for( var interesse in dadosJson2 ){
      InteresseAprendizagem p = InteresseAprendizagem(interesse["idInteresseAprendizagem"], interesse["idPessoa"],
          interesse["descricaoSimplicada"],interesse["descricaoCompleta"],interesse["dataCriacao"]);
      interesses.add( p );

    }
    // ignore: return_of_invalid_type
    return interesses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de interesses"),
      ),
      body: FutureBuilder<List<InteresseAprendizagem>>(
        future: _recuperaInteresses(),
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

                      List<InteresseAprendizagem> lista = snapshot.data;
                      InteresseAprendizagem post = lista[index];

                      return ListTile(
                        title: Text( post.descricaoCompleta ),
                        subtitle: Text( post.idInteresseAprendizagem.toString() ),
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