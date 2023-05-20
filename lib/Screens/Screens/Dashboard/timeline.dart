import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunisiacleanup/Screens/Map/home_page.dart';
import 'package:tunisiacleanup/Screens/Screens/Dashboard/StatsPage.dart';
import 'package:tunisiacleanup/Screens/Screens/Dashboard/dashboard.dart';
import 'package:tunisiacleanup/Screens/Screens/Dashboard/dashboardmodel.dart';
import 'package:tunisiacleanup/Screens/src/constants/colors.dart';
import 'package:tunisiacleanup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:tunisiacleanup/widgets/Dashboard/bottomNavigationItem.dart';
import 'package:tunisiacleanup/widgets/Dashboard/dashboard_add_icon.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}



class _TimelineState extends State<Timeline> {
  List<DashModel> data = [];
  List<Map<String, dynamic>> wasteTypes = [
    {'name': 'Waste Type 1'},
    {'name': 'Waste Type 2'},
    {'name': 'Waste Type 3'},
    // Add more waste types as needed
  ];

  ValueNotifier<int> bottomNavigatorTrigger = ValueNotifier(0);
  XFile? image;
  final PageStorageBucket bucket = PageStorageBucket();

  Future<void> _imageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
        data.add(DashModel(name: File(pickedImage.path), isSelected: false));
      });
    }
  }

  Future<void> _imageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
        data.add(DashModel(name: File(pickedImage.path), isSelected: false));
      });
    }
  }

  void _showOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choose an option"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () async {
                  _imageFromGallery(context);
                  Navigator.pop(context);
                },
                title: const Text("From gallery"),
                leading: const Icon(Icons.photo),
              ),
              ListTile(
                onTap: () async {
                  _imageFromCamera(context);
                  Navigator.pop(context);
                },
                title: const Text("From Camera"),
                leading: const Icon(Icons.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CollectionReference wasteTypesCollection =
  FirebaseFirestore.instance.collection('Reclamations');

  Future<void> addWasteTypesCollection() async {
    if (image == null) {
      // No image selected, handle the error or display a message
      return;
    }

    final destination = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    Set<int> selectedTypeIndices = {}; // Initialize or update this set with the selected type indices
    String? selectedLocation; // Assign a value to selectedLocation
    String? selectedMunicipaliteName; // Assign a value to selectedMunicipaliteName
    final adresseReclamationController = TextEditingController();

    final task = firebase_storage.FirebaseStorage.instance.ref(destination).putFile(File(image!.path));

    setState(() {});

    try {
      final snapshot = await task;
      final downloadURL = await snapshot.ref.getDownloadURL();

      print('Download-Link: $downloadURL');

      await wasteTypesCollection.add({
        'wasteType': selectedTypeIndices.map((index) => wasteTypes[index]['name']).toList(),
        'Municipalite': selectedLocation,
        'ville': selectedMunicipaliteName,
        'Adresse de réclamation': adresseReclamationController.text,
        'image': downloadURL,
      });

      print('Réclamations ajoutées avec succès!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Réclamations ajoutées avec succès!')),
      );
    } catch (error) {
      print('Erreur lors de l\'ajout des Réclamations: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout des Réclamations: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> dashBoardScreens = [
      Dashboard(data: data),
      StatsPage(),
      GoogleMapPage(),
    ];

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Stack(
        children: [
          DarkRadialBackground(
            color: MyColors.primaryColor,
            position: "topLeft",
          ),
          ValueListenableBuilder(
            valueListenable: bottomNavigatorTrigger,
            builder: (BuildContext context, _, __) {
              return PageStorage(
                bucket: bucket,
                child: dashBoardScreens[bottomNavigatorTrigger.value],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 90,
        padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: MyColors.primaryColor.withOpacity(0.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigationItem(
              itemIndex: 0,
              notifier: bottomNavigatorTrigger,
              icon: Icons.widgets,
            ),
            const Spacer(),
            BottomNavigationItem(
              itemIndex: 1,
              notifier: bottomNavigatorTrigger,
              icon: FeatherIcons.pieChart,
            ),
            const Spacer(),
            BottomNavigationItem(
              itemIndex: 2,
              notifier: bottomNavigatorTrigger,
              icon: FeatherIcons.mapPin,
            ),
            const Spacer(),
            DashboardAddButton(
              iconTapped: (() {
                _showOption(context);
              }),
            ),
          ],

        ),
      ),
    );
  }
}

