import 'package:flutter/material.dart';
import 'package:day14/Member.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Painel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //controllers
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  String _mensagemErro="";

  validadeMember() async{

    String username = _controllerUsername.text;
    String password = _controllerPassword.text;

    final prefs = await SharedPreferences.getInstance();


    Map<String, dynamic> corpo = {'email': username, 'password': password};

    String url ="http://200.137.66.25:8080/api/login";



    http.Response response = await http.post(url,body: corpo);
    var resposta = json.decode(response.body);
    print(resposta["email"]);
    print(resposta["memberID"]);

    if(resposta["email"]=="erro_credenciais"){
      print("Erro ao tentar logar...dados equivocados !!!");
      setState((){
        _mensagemErro = "Credenciais inválidas !!!";
      });

    }else{
      await prefs.setInt("memberID", resposta["memberID"]);
      await prefs.setString("username", resposta["username"]);
      setState((){
        _mensagemErro = "";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Painel(memberID:resposta["memberID"],username:resposta["username"])
          )
      );
    }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      body:Container(
        //decoration: BoxDecoration(color: Color(0xffC0C0C0)),
        //decoration: BoxDecoration(color: Colors.white),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Center(
                    child: Text("LIEdUbiquo", style: TextStyle(color: Colors.indigo, fontSize: 40)),
                  ),
                      /*)
                  Image.asset(
                    "imagens/learn2.jpg",
                    width: 200,
                    height: 150,
                  ),
                  */

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerUsername,
                    //autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Usuário",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                  ),
                ),
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32)
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16,bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(32, 15, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                      ),
                      onPressed: (){
                        validadeMember();
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Center(
                    child: Text(_mensagemErro,
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                  ),
                  /*)
                  Image.asset(
                    "imagens/learn2.jpg",
                    width: 200,
                    height: 150,
                  ),
                  */

                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
