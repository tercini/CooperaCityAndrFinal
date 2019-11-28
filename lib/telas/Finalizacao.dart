import 'package:city/telas/Painel.dart';
import 'package:flutter/material.dart';

class Finalizacao extends StatefulWidget {
  @override
  _FinalizacaoState createState() => _FinalizacaoState();
}

class _FinalizacaoState extends State<Finalizacao> {


  List<String> itensMenu = [
    "Deslogar"
  ];



  _deslogarUsuario() async{
    //FirebaseAuth auth = FirebaseAuth.instance;
    //await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
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

  navegarMenuInicial()
  {
    print("entrou no registrar");
    //Navigator.pushReplacementNamed(context, "/painel");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Painel()),
      ModalRoute.withName('/painel'),
    );
    //Navigator.pushAndRemoveUntil(context, "/painel", predicate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Finalização'),
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
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/fundo.png"),
                fit: BoxFit.cover
            )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Center(
                    child: Text(
                      //_mensagemErro,
                      "Seu incidente foi registrado com sucesso.",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Retornar ao menu inicial",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color(0xff1ebbd8),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: (){
                      navegarMenuInicial();
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      //_mensagemErro,
                      "",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


