import 'dart:async';

import 'package:city/telas/Globals.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class Localizacao extends StatefulWidget {
  @override
  _LocalizacaoState createState() => _LocalizacaoState();
}

class _LocalizacaoState extends State<Localizacao> {

  //Map<String, double> currentLocation = new Map();

  Completer<GoogleMapController> _controller = Completer();

  double latitude = 0;
  double longitude = 0;

  Future<LocationData> currentLocation ;

  //StreamSubscription<Map<String,double>> locationSubscription;


  var location = new Location();
  String error;

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



  @override
  void initState()  {

    initPlatformState();
    _googleMap(context);
    //currentLocation['latitude'] = 0.0;
    //currentLocation['longitude'] = 0.0;

    //initPlatformState();

    //initPlatformState();
    //locationSubscription = location.onLocationChanged().listen((Map<String, double> result){
    /*
      setState(() {
        currentLocation = result;
      });
      */


  }

  irParaDescricao()
  {
    gLat = latitude;
    gLon = longitude;
    print("entrou no registrar");
    Navigator.pushNamed(context, "/descricao");
  }
  _onMapCreated(GoogleMapController controller)
  {

    _controller.complete(controller);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 20.0)));
  }

  _faznada()
  {

  }

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        appBar: AppBar(title: Text('Localização'),
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
        body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FutureBuilder<LocationData>(
                  future:  initPlatformState(),
                  // ignore: missing_return
                  builder: (context, snapshot){

                    switch( snapshot.connectionState ) {
                      case ConnectionState.none :
                      case ConnectionState.waiting :
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active :
                      case ConnectionState.done :
                        print(snapshot.data.latitude);
                        latitude = snapshot.data.latitude;
                        longitude = snapshot.data.longitude;
                        return _googleMap(context);
                    }
                  },
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
                    initPlatformState();
                    _googleMap(context);
                    irParaDescricao();
                  },


                ),
              ),


              //Text("Latitude: " + latitude.toString()),
              //Text("Longitude: " + longitude.toString()),



            ],)

          ,),
        );

  }

  @override
  Widget _googleMap(BuildContext context) {
    print("latitude");
    print(latitude);
    initPlatformState();
    return new  MaterialApp(
        home: new Scaffold(

          body:

                GoogleMap(

                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 20.0
                  ),

                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  compassEnabled: true,

                ),
        ),
        debugShowCheckedModeBanner: false,
    );
  }

  Future<LocationData> initPlatformState() async  {
    try {

      print("chegou aqui");

      setState(() {
        currentLocation =   location.getLocation();
      });

      print(currentLocation);

      print("gerando localizacaooo vrawwwww");

      return  await currentLocation;

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
        print(error);
      }
      currentLocation = null;
      print('erro2');
    }
  }

}


