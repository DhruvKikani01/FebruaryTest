import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {

  Location location = Location();

  bool _serviceEnabled = false;
  late PermissionStatus permissionGranted;
  late LocationData _locationData;

  Future _getLocation() async{
    print("Permission Granted");
    if(permissionGranted == PermissionStatus.deniedForever){
      AppSettings.openAppSettings(type: AppSettingsType.settings);
    }else{
      _locationData = await location.getLocation();
      print(_locationData);
    }
  }

  Future _checkLocationServiceEnable() async{
    _serviceEnabled = await location.serviceEnabled();
    if(_serviceEnabled == false){
      _serviceEnabled = await location.requestService();
      if(_serviceEnabled == false){
        return;
      }
    }
  }

  Future _checkLocationPermissionGranted() async{
    permissionGranted = await location.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted == PermissionStatus.denied){
        return;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLocationPermissionGranted();
    _checkLocationServiceEnable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps Screen"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(22.30, 73.19),
        zoom: 11),
        myLocationEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: (){
        _getLocation();
      },
      child: Icon(Icons.pin_drop),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
