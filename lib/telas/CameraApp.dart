import 'dart:convert';
import 'dart:io';
import 'package:city/telas/Api.dart';
import 'package:city/telas/Globals.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';



class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {

  List<String> itensMenu = [
    "Deslogar"
  ];



  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
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

  Completer<GoogleMapController> _controller = Completer();

  File imageFile;


  _openCamera(BuildContext context) async
  {
    print("antes");
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    print("passou aqui");
    this.setState(() {
      imageFile = picture;
      print(imageFile.toString());
      print(imageFile.toString());
      print(imageFile.toString());
      print(imageFile.toString());
      print(imageFile.toString());
      print(imageFile.toString());


    });
    //Navigator.of(context).pop();
  }

  _confirmarFoto()
  {
    Navigator.pushNamed(context, "/localizacao");

  }

  @override
  Widget _decideImageView() {
    if(imageFile == null)
      return Text("");
    else
    {
      print("deu certo");
      List<int> imageBytes =  imageFile.readAsBytesSync();
      String imageB64 = base64Encode(imageBytes);


      gImg = imageB64;

      return Image.file(imageFile, width: 200, height: 200);
      //return _confirmarFoto();
      //return Text("");

    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capturar Foto"),
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


                _decideImageView(),

                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(

                    child: GestureDetector(
                      child: Image(
                        image: AssetImage("imagens/camera.png"),
                        width: 100,
                        height: 100,
                      ),
                      onTap: (){
                        _openCamera(context);

                      },
                    ),
                  ),
                ),
                /*_carregando
                    ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                    : Container(),*/

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Confirmar Foto",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color(0xff1ebbd8),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: (){
                      _confirmarFoto();
                      //_registrar();
                      /*_validarCampos();*/
                    },
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      /*_mensagemErro*/"",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
