import 'dart:io';
import 'dart:typed_data';
import 'package:city/model/Reclamacao.dart';
import 'package:city/telas/Api.dart';
import 'package:city/telas/Globals.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io' as io;



class ExibirProblemas extends StatefulWidget {
  @override
  _ExibirProblemasState createState() => _ExibirProblemasState();
}

class _ExibirProblemasState extends State<ExibirProblemas> {

  Api api = new Api();

  String teste = "";

  List<String> itensMenu = [
    "Deslogar"
  ];

  _deslogarUsuario() async{
    //irebaseAuth auth = FirebaseAuth.instance;
    //await auth.signOut();
    Navigator.pushNamed(context, "/");
  }

  _escolhaMenuItem(String escolha){

    switch( escolha ){
      case "Deslogar" :
        _deslogarUsuario();
        break;
      case "Configurações" :
        break;
    }

  }

  _finalizarReclamacao(int idReclamacao)
  {
    Api api = new Api();
    api.finalizarReclamacao(idReclamacao);
    Navigator.pushNamed(context, "/finalizarreclamacao");

  }

  Uint8List bytes;

  Image imgDecor;

  var base64;

  ImageProvider imgProv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Incidentes Registrados"),
        actions: <Widget>[
          PopupMenuButton<String>(
          onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ]
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/fundo.png"),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                "", //"""Clique sobre um dos itens para visualizar mais informações",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Reclamacao>> (
                future: api.recuperarReclamacoes2(),
                // ignore: missing_return
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
                        return ListView.separated(
                            itemBuilder: (context, index){


                              //print(snapshot.data[2].imagem);

                              List<Reclamacao> lst = snapshot.data;
                              Reclamacao rec = lst[index];

                                  
                                print("xxxxxxxxxxxxxxxxxxxxxxxx");

                              //print("http://192.168.1.25:8080/"+rec.imagem.replaceAll( "../DenuncieSpam/wwwroot/", ""));

                              print("http://cooperacity-001-site1.btempurl.com/images/"+ rec.imagem.substring (rec.imagem.indexOf("incidentes"), rec.imagem.indexOf(".png")).replaceAll("\\", "/")+ ".png");

                              print("http://cooperacity-001-site1.btempurl.com/images/incidentes/"+ rec.imagem.substring (rec.imagem.indexOf("incidentes"), rec.imagem.indexOf(".png")) + ".png");


                                  if(gEmail == rec.email)
                                  {
                                    print(gEmail);
                                    print("-------------------------------------------");
                                    print(rec.email);
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          height: 300,
                                          child: Padding(

                                            padding: EdgeInsets.only(bottom: 10),
                                            //teste comentario git
                                            //child:  Image.network(rec.imagem,//.replaceAll( "../DenuncieSpam/wwwroot/", ""),
                                            child:  Image.network("http://10.0.2.2:4783/images/"+ rec.imagem.substring (rec.imagem.indexOf("incidentes"), rec.imagem.indexOf(".png")).replaceAll("\\", "/")+ ".png",
                                              /*Image.memory(
                                              Base64Decoder().convert(rec.imagem),*/
                                              width: 300,
                                              height: 300,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("Descrição:     " + rec.descricao + "\n", style: TextStyle(color: Colors.lightGreenAccent, fontStyle: FontStyle.normal),  ),

                                          subtitle: Text("Endereço:     " + rec.endereco, style: TextStyle(color: Colors.lightGreenAccent, fontStyle: FontStyle.normal), ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5, bottom: 10),
                                          child: RaisedButton(
                                            child: Text(
                                              "Finalizar",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                            color: Colors.green,
                                            //padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                            onPressed: (){
                                              //_validarCampos();
                                              _finalizarReclamacao(rec.idreclamacao);

                                            },
                                          ),
                                        ),

                                      ],
                                    );
                                  }
                                  else
                                  {
                                    return Column(

                                      children: <Widget>[
                                        Container(
                                          height: 300,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            //child:  Image.network("http://cooperacity-001-site1.btempurl.com/images/"+ rec.imagem.substring (rec.imagem.indexOf("incidentes"), rec.imagem.indexOf(".png")).replaceAll("\\", "/")+ ".png",
                                            child:  Image.network("http://10.0.2.2:4783/"+rec.imagem,//.replaceAll( "../DenuncieSpam/wwwroot/", ""),
                                            /*Image.memory(
                                              Base64Decoder().convert(rec.imagem),*/
                                              width: 300,
                                              height: 300,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text("Descrição:     " + rec.descricao + "\n", style: TextStyle(color: Colors.lightGreenAccent, fontStyle: FontStyle.normal),  ),

                                          subtitle: Text("Endereço:     " + rec.endereco, style: TextStyle(color: Colors.lightGreenAccent, fontStyle: FontStyle.normal), ),
                                        ),

                                      ],
                                    );
                                  }

                            },
                            separatorBuilder: (context, index) => Divider(
                              height: 50,
                              color: Colors.white,
                            ),
                            itemCount: snapshot.data.length
                        );
                        /*
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){

                              print("teste");

                              print("yyyyyyyyyyy");

                              //Reclamacao reclamacao = lista[index];

                              //String teste = "";

                              List<Reclamacao> lst = snapshot.data;
                              Reclamacao rec = lst[index];



                              //teste = teste + snapshot.data[index].toString();

                              //print(teste);
                              return ListTile(
                                title: Text(rec.descricao, style: TextStyle(color: Colors.white, fontSize: 15),),
                                subtitle: Text(rec.endereco.toString(), style: TextStyle(color: Colors.white, fontSize: 15),)
                                //subtitle: Text( reclamacao.endereco.toString() ),
                              );

                            }
                        );
                        */
                      }
                      break;
                  }

                },
              ),
            ),



          ],
        ),
      ),
    );
  }
}
