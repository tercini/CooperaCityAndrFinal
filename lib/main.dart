import 'package:city/Rotas.dart';
import 'package:city/telas/Cadastro.dart';
import 'package:city/telas/Home.dart';
import 'package:flutter/material.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff37474f),
  accentColor: Color(0xff546e7a)
);

void main(){
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: temaPadrao,
      initialRoute: "/",
      onGenerateRoute: Rotas.gerarRotas,
    )
  );
}
