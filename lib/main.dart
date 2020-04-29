import 'package:day14/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:day14/Painel.dart';
import 'package:http/http.dart';
import 'package:day14/interesseaprendizagem/InteresseAprendizagemCadastro.dart';
import 'package:day14/interesseaprendizagem/InteresseAprendizagemLista.dart';
import 'package:day14/interesseaprendizagem/InteresseAprendizagemPainel.dart';
import 'package:day14/Login.dart';
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: HomePage(),
    home: Login(),
    theme: ThemeData(
      primaryColor: Color(0xffC0C0C0),
      accentColor: Color(0xff25D366)
    ),

  )
);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              //Colors.orange[900],
              //Colors.orange[800],
              //Colors.orange[400]
              Colors.blue[400],
              Colors.blue[400],
              Colors.blue[400]
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height:40,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text("LIEDOBIQUO", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Seja bem vindo !", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      FadeAnimation(1.4, Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10)
                          )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: 30,),
                      FadeAnimation(1.5, Text("Esqueceu sua senha ?", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 20,),

                      FadeAnimation(1.6, Container(
                        //height: 50,
                        //margin: EdgeInsets.symmetric(horizontal: 50),
                        //decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(50),
                          //color: Colors.orange[900]
                        //),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text("Login"),
                              padding: EdgeInsets.all(15),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InteresseAprendizagemLista()
                                    )
                                );
                              },
                            )
                          ],
                        ),
                      )),

                      /*
                      SizedBox(height: 50,),
                      FadeAnimation(1.7, Text("Continuar com mídia social", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(1.8, Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue
                              ),
                              child: Center(
                                child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: FadeAnimation(1.9, Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black
                              ),
                              child: Center(
                                child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          )
                        ],
                      )
                      */
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
