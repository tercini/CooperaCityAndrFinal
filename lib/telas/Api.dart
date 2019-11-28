import 'dart:io';
import 'package:city/model/Reclamacao.dart';
import 'package:city/model/Registro.dart';
import 'package:city/model/Usuario.dart';
import 'package:city/telas/Globals.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:city/model/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



class Api{

  Api();


  String vCookie = "";

  //String _urlBaseLogin = "https://192.168.1.25:44372";

  //String _urlBaseLogin = "http://192.168.1.25:8080";

  //String _urlBaseLogin = "http://cooperacity-001-site1.btempurl.com";


  String _urlBaseLogin = "http://10.0.2.2:4783";
  //String _urlBaseLogin = "http://10.0.2.2:8080";
  //String _urlBaseLogin = "http://127.0.0.1:4783";


   get(String email, String senha) async {

    postLogin(email, senha);

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.getUrl(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/"));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhcGhhZWwudGVyY2luaUBob3RtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ0ZXJjaW5pIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW5pc3RyYWRvciIsImp0aSI6IjI2ZTFjNjA3LTUzOGEtNDc2Ni1iMTRiLWY0MjJkMzBhNjExMCIsImV4cCI6MTU2OTQzMTAxMH0.vq_n9brIeQqk-lM0e6gJKy_ZOF20tjmxTVboTxwNVIM');

    int posIni = vCookie.indexOf("=");
    int posFin = vCookie.indexOf(";");

    String coo = vCookie.substring(posIni+1, posFin);

    request.cookies.add(Cookie(".AspNetCore.Identity.Application", coo));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    print (reply);



  }

  Map<String, String> idRecToJson(int idReclamacao) {
    return {
      "idReclamacao": idReclamacao.toString(),
    };
  }

  finalizarReclamacao (int idReclamacao) async
  {
    try
    {





      var header = idRecToJson(idReclamacao);

      http.Response response = await http.get(_urlBaseLogin + "/api/ApiReclamacoes/Delete", headers: header);

      /*
      print("passou do corpo");

      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/Delete"));

      print("passou pelo ");

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/Delete")));

      HttpClientResponse response = await request.close();

      cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/Delete"), response.cookies);



      String reply = await response.transform(utf8.decoder).join();

      dynamic cookizados = response.cookies;

      vCookie  = cookizados.toString();


      print(reply);

      gIdUsuario = reply;
      */
    }
    catch(err)
    {
      print("error");
      return 0;
    }
  }


  buscarIdUsuario () async
  {
    try
    {

      Login login = new Login(gEmail, gSenha);

      var corpo = json.encode(
          login.toJson()
      );



      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/BuscarIdUsuario"));

      print("passou pelo ");

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/BuscarIdUsuario")));

      HttpClientResponse response = await request.close();

      cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Login"), response.cookies);

      String reply = await response.transform(utf8.decoder).join();

      dynamic cookizados = response.cookies;

      vCookie  = cookizados.toString();


      print(reply);

      gIdUsuario = reply;
    }
    catch(err)
    {
      print("error");
      return 0;
    }
  }


  Future<int> postLogin(String email, String senha) async {

    try
    {

      Login login = new Login(email, senha);

      var corpo = json.encode(
          login.toJson()
      );



      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Login"));

      print("passou pelo ");

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Login")));

      HttpClientResponse response = await request.close();

      cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Login"), response.cookies);

      String reply = await response.transform(utf8.decoder).join();

      dynamic cookizados = response.cookies;

      vCookie  = cookizados.toString();


      print(reply);

      if(reply.contains("token"))
      {
        buscarIdUsuario();
        return 1;
      }
      else
        return 0;
    }
    catch(err)
    {

      print("error");
      print(err);
      return 0;
    }


  }


  Future<int> postCreate(String nome, String cpf, String telefone, String usuario, String email, String senha) async {

    try
    {


      Registro registro = new Registro(nome, cpf, telefone, usuario, email, senha);


      var corpo = json.encode(
          registro.toJson()
      );



      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Create"));

      print("passou pelo ");

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Create")));

      HttpClientResponse response = await request.close();

      cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiUsuarios/Create"), response.cookies);

      String reply = await response.transform(utf8.decoder).join();

      dynamic cookizados = response.cookies;

      vCookie  = cookizados.toString();

      print(reply);

      if(reply.contains("cadastrado"))
        return 1;
      else
        return 0;
    }
    catch(err)
    {
      print("error");
      return 0;
    }


  }

  Map<String, String> toJson() {
    return {
      "email": gEmail,
      "senha": gSenha,
    };
  }

  Future<List<Reclamacao>> recuperarReclamacoes2() async {

    List<Reclamacao> lstRec = new List();
    try
    {
      print("entrou na reclamacao");
      //this._descricao, this._imagem, this._latitude, this._longitude, this._endereco


      var header = toJson();

      http.Response response = await http.get(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens", headers: header);




      print("teste");

      print (response.body);




      var dJson = json.decode(response.body);



      for(var rec in dJson)
      {
        //print(rec["Imagem"]);
        Reclamacao r = new Reclamacao(rec["Descricao"], rec["Imagem"], 0.0, 0.0, rec["Endereco"], null);
        r.idusuario = rec["IdUsuario"];
        r.email = rec["Email"];
        r.idreclamacao = rec["IdReclamacao"];
        lstRec.add(r);
      }




      return lstRec;


      /*
      print(reclamacao.toJson());

      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens"));

      print("passou pelo ");

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens")));

      */

      //HttpClientResponse response = await request.close();

      //cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens"), response.cookies);

      //print("continue");

      //print(response.toList());

      //List<Reclamacao> reply = await response.toList<Reclamacao>();

      //var reply =  response.transform(utf8.decoder).listen(onData);

      ///dynamic cookizados = response.cookies;

      //vCookie  = cookizados.toString();



      //print(reply.toString());
      //Map<String, dynamic> reply = await response.transform(utf8.decoder).join();

      //print("testando" + reply);

      //List<Reclamacao> reply = await response.join(utf8); // .transform(utf8.decoder).join();



      //print(reply);
      /*

      List<Reclamacao> reclamacoes = List();

      for( var reclamacao in reply ){


        print("reclamacao: " + reclamacao["Descricao"] );
        Reclamacao r = Reclamacao(reclamacao["descricao"], reclamacao["imagem"], reclamacao["latitude"], reclamacao["longitude"],  reclamacao["endereco"],  reclamacao["usuario"]);
        reclamacoes.add( r );

      }

      return reclamacoes;
      */
    }
    catch(err)
    {
      print(err);
      print("error");
      return lstRec;
      //return 0;
    }

    /*
     print("recuperando reclamacoes");
    http.Response response = await http.get( _urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens");
    var dadosJson = json.decode( response.body );

    List<Reclamacao> reclamacoes = List();
    for( var reclamacao in dadosJson ){


      print("reclamacao: " + reclamacao["Descricao"] );
      Reclamacao r = Reclamacao(reclamacao["descricao"], reclamacao["imagem"], reclamacao["latitude"], reclamacao["longitude"],  reclamacao["endereco"],  reclamacao["usuario"]);
      reclamacoes.add( r );

    }
    return reclamacoes;
    //print( postagens.toString() );
     */
  }



  Future<List<Reclamacao>> recuperarReclamacoes() async {

    try
    {
      print("entrou na reclamacao");
      //this._descricao, this._imagem, this._latitude, this._longitude, this._endereco

      var usuario = new Login(gEmail, gSenha);


      print("instanciou usuario");

      Reclamacao reclamacao = new Reclamacao(gDes, gImg, gLat, gLon, "", usuario.toJsonReclamacao());

      print(usuario.toString());

      var corpo = json.encode(
          reclamacao.toJson()
      );


      print(reclamacao.toJson());

      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens"));

      print("passou pelo ");



      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens")));



      HttpClientResponse response = await request.close();

      cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens"), response.cookies);

      print("continue");

      //print(response.toList());

      //List<Reclamacao> reply = await response.toList<Reclamacao>();

      //var reply =  response.transform(utf8.decoder).listen(onData);

      dynamic cookizados = response.cookies;

      vCookie  = cookizados.toString();


      print("teste");





      print("continue2");
      var completer = new Completer();
      var contents = new StringBuffer();



      //print(lst);

      //String teste = "";
      int cont = 0;
      response.transform(utf8.decoder).listen((data) {




        contents.write( data.toString() );
        print(data.toString());

        //teste = teste + data.toString();

      }, onDone: () => completer.complete(contents.toString()));

      //print(teste);




      
      print("xxxxxxxxxxxxxxxxx");

      return   completer.future;

      //print(reply.toString());
      //Map<String, dynamic> reply = await response.transform(utf8.decoder).join();

      //print("testando" + reply);

      //List<Reclamacao> reply = await response.join(utf8); // .transform(utf8.decoder).join();



      //print(reply);
      /*

      List<Reclamacao> reclamacoes = List();

      for( var reclamacao in reply ){


        print("reclamacao: " + reclamacao["Descricao"] );
        Reclamacao r = Reclamacao(reclamacao["descricao"], reclamacao["imagem"], reclamacao["latitude"], reclamacao["longitude"],  reclamacao["endereco"],  reclamacao["usuario"]);
        reclamacoes.add( r );

      }

      return reclamacoes;
      */
    }
    catch(err)
    {
      print("error");
      //return 0;
    }

    /*
     print("recuperando reclamacoes");
    http.Response response = await http.get( _urlBaseLogin + "/api/ApiReclamacoes/RecuperarPostagens");
    var dadosJson = json.decode( response.body );

    List<Reclamacao> reclamacoes = List();
    for( var reclamacao in dadosJson ){


      print("reclamacao: " + reclamacao["Descricao"] );
      Reclamacao r = Reclamacao(reclamacao["descricao"], reclamacao["imagem"], reclamacao["latitude"], reclamacao["longitude"],  reclamacao["endereco"],  reclamacao["usuario"]);
      reclamacoes.add( r );

    }
    return reclamacoes;
    //print( postagens.toString() );
     */
  }

  Future<int> createReclamacao() async {

    try
    {
      print("entrou na reclamacao");
      //this._descricao, this._imagem, this._latitude, this._longitude, this._endereco

      var usuario = new Login(gEmail, gSenha);


      print("instanciou usuario");

      Reclamacao reclamacao = new Reclamacao(gDes, gImg, gLat, gLon, "", usuario.toJsonReclamacao());

      print(usuario.toString());

      var corpo = json.encode(
          reclamacao.toJson()
      );

      print(reclamacao.toJson());

      var cj=new CookieJar();

      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      print("passou nada");

      HttpClientRequest request = await client.postUrl(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/Create"));

      print("passou pelo ");

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(corpo));

      request.cookies.addAll(cj.loadForRequest(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/Create")));

      HttpClientResponse response = await request.close();

      cj.saveFromResponse(Uri.parse(_urlBaseLogin + "/api/ApiReclamacoes/Create"), response.cookies);

      String reply = await response.transform(utf8.decoder).join();

      dynamic cookizados = response.cookies;

      vCookie  = cookizados.toString();

      print(reply);

      if(reply.contains("token"))
        return 1;
      else
        return 0;
    }
    catch(err)
    {
      print("error");
      return 0;
    }


  }


}