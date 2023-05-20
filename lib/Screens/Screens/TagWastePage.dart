import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tunisiacleanup/Screens/src/constants/colors.dart';
import 'package:path/path.dart' as path;
import 'Dashboard/HistoryScreen.dart';

class WasteTypePage extends StatefulWidget {
  const WasteTypePage({Key? key,
  }) : super(key: key);
  @override
  _WasteTypePageState createState() => _WasteTypePageState();
}
class _WasteTypePageState extends State<WasteTypePage> {
  List<Map<String, dynamic>> _registeredRequests = [];
  Set<int> _selectedTypeIndices = {};
  String? _selectedLocation;
  String? _selectedmunicipaliteName;
  final CollectionReference wasteTypesCollection =
  FirebaseFirestore.instance.collection('Reclamations');
  final _adresseReclamationController = TextEditingController();



  String location ='Cliquez sur un bouton pour localiser votre emplacement';


  // Variables pour l'animation de la boîte
  double _boxSize = 100.0;
  Color _boxColor = Colors.white;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    setState(()  {
    });
  }




  void _selectType(int index) async {
    if (_selectedTypeIndices.contains(index)) {
      _selectedTypeIndices.remove(index);
    } else {
      _selectedTypeIndices.add(index);
      _boxSize = 150.0; // taille de la boîte agrandie
      _boxColor = MyColors.colorScheme;
    }



    setState(() {});
  }


  Stream<QuerySnapshot> getWasteTypesForLocation(String location) {
    return wasteTypesCollection.where('ville', isEqualTo: location).snapshots();
  }

  final List<Map<String, dynamic>> _wasteTypes = [
    {'name': 'Papier', 'icon': Icons.article_outlined},
    {'name': 'Plastique', 'icon': Icons.local_drink_outlined},
    {'name': 'Verre', 'icon': Icons.wine_bar_outlined},
    {'name': 'Métal', 'icon': Icons.shopping_bag_outlined},
    {'name': 'Textile', 'icon': Icons.format_shapes_outlined},
    {'name': 'Autre', 'icon': Icons.info_outline},
  ];
  final List<String> _locations = [
    'Tunisie', 'Sfax','Ben Arous','Ariana', 'Beja', 'Bizerte',
    'Manouba', 'Tataouine', 'Tozeur',
    'Jendouba', 'Zaghouan', 'Siliana', 'Nabeul',
    'Monastir', 'Sousse', 'Mahdia', 'Gabes', 'Sidi Bouzid',
    'Kebili', 'Gafsa', 'Kasserine', 'Kairouan',
    'El Kef', 'Médenine',
  ];
  final Map<String, List<String>> _MunicipaliteNames = {
    'Tunisie': ['Suha'],
    'Sfax': [ "Sfax Ville",
      "Sfax Ouest", "Sfax Sud", "Sfax Est", "Sfax Nord", "Sfax Centre",
      "Sfax Medina", "Sakiet Ezzit", "Sakiet Eddaier", "Sakiet Ezzit Nord",
      "Sakiet Eddaier Nord",],
    'Ben Arous': ["Ben Arous",
      "Bou Mhel","el-Bassatine",
      " El Mourouj",
      " Ezzahra",
      "Fouchana",
      " Hammam Chott",
      "Mohamedia",
      "Medina Jedida",
      "Mégrine",
      "Mornag"
          "Radès",],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Get.arguments != null && Get.arguments is File
                ? Image.file(Get.arguments)
                : Container(),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextField(
                      controller: _adresseReclamationController,
                      decoration: InputDecoration(
                        labelText: 'Adresse de réclamation',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green, // set border color to green
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                      ),
                    ),
                    SizedBox(height: 20), // Add some spacing between the address field and the dropdowns
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                ),
                              ),
                              child: Container(
                                width: 200,
                                height: 50,
                                child: DropdownButtonFormField(
                                  value: _selectedLocation,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLocation = value as String?;
                                      _selectedmunicipaliteName = null;
                                    });
                                  },
                                  items: _locations.map((location) {
                                    return DropdownMenuItem(
                                      value: location,
                                      child: Text(location),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green, // set border color to green
                                      ),
                                    ),
                                    hintText: 'Sélectionner ville',
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Container(
                                width: 200,
                                height: 50,
                                child: SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField(
                                          value: _selectedmunicipaliteName,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedmunicipaliteName = value as String?;
                                            });
                                          },
                                          items: _MunicipaliteNames[_selectedLocation ?? '']?.map((name) {
                                            return DropdownMenuItem(
                                              value: name,
                                              child: Text(name),
                                            );
                                          }).toList() ?? [],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.green, // set border color to green
                                              ),
                                            ),
                                            hintText: 'Municipalité',
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
                        SizedBox(height: 10,),



                      ],
                    ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _wasteTypes.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final wasteType = _wasteTypes[index];
                          return GestureDetector(
                            onTap: () => _selectType(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              height: _selectedTypeIndices.contains(index) ? _boxSize : 100.0,
                              width: _selectedTypeIndices.contains(index) ? _boxSize : 100.0,
                              decoration: BoxDecoration(
                                color: _selectedTypeIndices.contains(index) ? _boxColor : Colors.white,
                                borderRadius: BorderRadius.circular(_selectedTypeIndices.contains(index) ? 20.0 : 0.0),
                                border: Border.all(
                                  color: _selectedTypeIndices.contains(index) ? Colors.transparent : Colors.grey,
                                  width: _selectedTypeIndices.contains(index) ? 0.0 : 1.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(wasteType['icon'] as IconData),
                                  const SizedBox(height: 8.0),
                                  Text(wasteType['name'] as String),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () async {
                              Position position = await _getGeoLocationPosition();
                              location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
                              GetAddressFromLatLong(position);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.btnColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                splashColor: MyColors.btnBorderColor,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Text(
                                    'Position',
                                    style: TextStyle(
                                      color: Color(0xFF006064),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16), // Add spacing between the buttons
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              // Validate the data before proceeding
                              if (_selectedTypeIndices.isEmpty ||
                                  _selectedLocation!.isEmpty ||
                                  _selectedmunicipaliteName!.isEmpty ||
                                  _adresseReclamationController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text("Attention"),
                                      content: Text("Veuillez remplir tous les champs."),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                                return; // Stop further execution
                              }

                              // Upload the image file to Firebase Storage
                              final fileName = path.basename(Get.arguments.path); // Get the file name from the path
                              final task = FirebaseStorage.instance.ref("images/$fileName").putFile(Get.arguments);

                              // Get the geolocation position
                              Position position = await _getGeoLocationPosition();
                              double latitude = position.latitude;
                              double longitude = position.longitude;

                              // Save the data in Firestore
                              String imageUrl = await task.snapshot.ref.getDownloadURL();
                              await wasteTypesCollection.add({
                                'wasteType': _selectedTypeIndices.map((index) => _wasteTypes[index]['name']).toList(),
                                'ville': _selectedLocation,
                                'Municipalite': _selectedmunicipaliteName,
                                'Adresseréclamation': _adresseReclamationController.text,
                                'latitude': latitude,
                                'longitude': longitude,
                                'image': imageUrl,
                              });

                              // Display the success dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Succès"),
                                    content: Text("Vos informations ont été envoyées avec succès à la municipalité"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [MyColors.primaryColor, MyColors.colorScheme],
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Text(
                                    "Continuer",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}