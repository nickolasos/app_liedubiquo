import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Member {


String _email;
String _password;

Member();

String get password => _password;

set password(String value) {
  _password = value;
}

String get email => _email;

set email(String value) {
  _email = value;
}

validadeMember(String email,String password) async{

  String url ="http://apipg.ddns.net/api/login";
  http.Response response = await http.post(
    url,
    headers: {
      "Content-type": "application/json; charset=UTF-8"
    },
    body:{
      email: email,
      password: password
    }
  );
  print("resposta: ${response.statusCode}");
  print("resposta: ${response.body}");
}



}