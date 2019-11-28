import 'package:city/telas/Cadastro.dart';
import 'package:city/telas/CameraApp.dart';
import 'package:city/telas/Descricao.dart';
import 'package:city/telas/ExibirProblemas.dart';
import 'package:city/telas/Finalizacao.dart';
import 'package:city/telas/FinalizarReclamacao.dart';
import 'package:city/telas/Home.dart';
import 'package:city/telas/Localizacao.dart';
import 'package:city/telas/Painel.dart';
import 'package:city/telas/Problema.dart';
import 'package:flutter/material.dart';

class Rotas{

  static Route<dynamic> gerarRotas(RouteSettings settings){
    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
          builder: (_) => Home()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => Cadastro()
        );
      case "/painel" :
        return MaterialPageRoute(
            builder: (_) => Painel()
        );
      case "/problema" :
        return MaterialPageRoute(
            builder: (_) => Problema()
        );
      case "/cameraapp" :
        return MaterialPageRoute(
            builder: (_) => CameraApp()
        );
      case "/localizacao" :
        return MaterialPageRoute(
            builder: (_) => Localizacao()
        );
      case "/descricao" :
        return MaterialPageRoute(
            builder: (_) => Descricao()
        );
      case "/finalizacao" :
        return MaterialPageRoute(
            builder: (_) => Finalizacao()
        );
      case "/exibirproblemas" :
        return MaterialPageRoute(
            builder: (_) => ExibirProblemas()
        );
      case "/finalizarreclamacao" :
        return MaterialPageRoute(
            builder: (_) => FinalizarReclamacao()
        );

      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text("Tela não encontrada!"),),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );
  }

}