import 'package:city/telas/Api.dart';
import 'package:city/telas/Globals.dart';
import 'package:flutter/material.dart';




class Descricao extends StatefulWidget {
  @override
  _DescricaoState createState() => _DescricaoState();
}

class _DescricaoState extends State<Descricao> {

  TextEditingController _controllerDescricao = TextEditingController();

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


  irParaFinalizacao()
  {
    gDes = _controllerDescricao.text;
    print(gImg);
    print(gLat);
    print(gLon);
    print(gDes);

    print("passou das vars");

    Api api = new Api();
    api.createReclamacao();


    Navigator.pushNamed(context, "/finalizacao");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Descrição'),
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
                TextField(
                  controller: _controllerDescricao,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  maxLines: 12,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Descrição do problema",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color(0xff1ebbd8),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: (){
                      //_validarCampos();
                      irParaFinalizacao();
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

