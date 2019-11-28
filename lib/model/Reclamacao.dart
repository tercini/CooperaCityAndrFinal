import 'package:city/model/Login.dart';
import 'package:city/model/Usuario.dart';
import 'package:city/telas/Globals.dart';

class Reclamacao {

  int _idreclamacao;
  String _idUsuario;
  String _email;
  String _descricao;
  String _imagem;
  double _latitude;
  double _longitude;
  String _endereco;
  Map _usuario;


  Reclamacao(this._descricao, this._imagem, this._latitude, this._longitude, this._endereco, this._usuario);

  Map toJson() {
    return {
      "Descricao": this._descricao,
      "Imagem": this._imagem,
      "Latitude": this._latitude,
      "Longitude": this._longitude,
      "Endereco": this._endereco,
      "Usuario": this._usuario = new Login(gEmail, gSenha).toJsonReclamacao(),
    };
  }


  int get idreclamacao => _idreclamacao;

  set idreclamacao(int value) {
    _idreclamacao = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get idusuario => _idUsuario;

  set idusuario(String value) {
    _idUsuario = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  Map get usuario => _usuario;

  set usuario(Map value) {
    _usuario = value;
  }


}