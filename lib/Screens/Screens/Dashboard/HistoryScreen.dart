
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../widgets/Shapes/roundedborder_with_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HistoryScreen extends StatefulWidget {


  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>?> ?reclamations;

  @override
  void initState() {
    super.initState();
    fetchReclamations();
  }

  Future<void> fetchReclamations() async {
    final snapshot = await FirebaseFirestore.instance.collection('Reclamations').get();
    setState(() {
      reclamations = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    if (reclamations == null) {
      // Display a loading indicator while fetching data
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (reclamations!.isEmpty) {
      // Display a placeholder widget when the list is empty
      return Scaffold(
        body: Center(
          child: Text('No reclamations found.'),
        ),
      );
    } else {
      // Build the UI using the fetched reclamations
      return Scaffold(
        backgroundColor: Color(0xFF006064),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: RoundedBorderWithIcon(icon: Icons.arrow_back),
          ),
          title: const Text(
            "Historique",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: reclamations?.length,
          itemBuilder: (context, index) {
            final reclamation = reclamations?[index];

            // Extract the required fields from the reclamation data
            final wasteType = List<String>.from(reclamation?['wasteType'] ?? []);
            final Municipalite = reclamation?['Municipalite'] ?? '';
            final ville = reclamation?['ville'] ?? '';
            final status = reclamation?['status'] ?? '';
            final adresseReclamation = reclamation?['Adresseréclamation'] ?? '';
            final latitude = reclamation?['latitude'] ?? 0.0;
            final longitude = reclamation?['longitude'] ?? 0.0;
            final image = reclamation?['image'] ?? '';

            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: HistoryItem(
                image: image,
                municipalite: Municipalite,
                ville: ville,
                adresseReclamation: adresseReclamation,
                latitude: latitude,
                longitude: longitude,
                wasteTypes: wasteType, status: status,
              ),
              secondaryActions: <Widget>[
                Container(
                  height: 60,
                  color: Colors.redAccent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, index);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Êtes-vous sûr de bien vouloir supprimer cet élément?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Supprimer"),
              onPressed: () {
                _deleteItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    // Perform the deletion logic for the selected item
    setState(() {
      reclamations?.removeAt(index);
    });
  }


  Widget HistoryItem({
    required String image,
    required String municipalite,
    required String ville,
    required String status,
    required String adresseReclamation,
    required double latitude,
    required double longitude,
    required List<String> wasteTypes, // Added wasteTypes parameter
  }) {
    return GestureDetector(
        onTap: () {
          // Handle item tap
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                      children: <Widget>[
                        Card(
                            color: Colors.white38,
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Card(
                                      color: Colors.white38,
                                      margin: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 250,
                                                height: 250,
                                                child: Image(
                                                  image: NetworkImage(image),
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF006064),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(Icons.delete),
                                                        color: Color(0xFF00C853),
                                                      ),
                                                      DropdownButton<String>(

                                                        icon: const Icon(Icons.arrow_drop_down),
                                                        iconSize: 24,
                                                        elevation: 16,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xFF00C853),
                                                        ),
                                                        onChanged: (String? newValue) {
                                                          if (newValue != null) {
                                                            setState(() {

                                                            });
                                                          }
                                                        },
                                                        items: wasteTypes.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                width: 410,
                                                height: 120,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF006064),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on_outlined,
                                                            size: 14,
                                                            color: Color(0xFF00C853),
                                                          ),
                                                          SizedBox(width: 4),
                                                          Text(
                                                            latitude.toString(),
                                                            style: TextStyle(
                                                              color: Color(0xFF00C853),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            longitude.toString(),
                                                            style: TextStyle(
                                                              color: Color(0xFF00C853),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8),
                                                         Text(
                                                          'Adresse de Reclamation :$adresseReclamation',
                                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                                        ),

                                                      Text(
                                                        'Ville: $ville',
                                                        style: TextStyle(fontSize: 13, color:Colors.white),
                                                      ),
                                                      Text(
                                                        'Municipalite: $municipalite',
                                                        style: TextStyle(fontSize: 13,color:Colors.white),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                        'état des réclamation: $status',
                                                        style: TextStyle(fontSize: 14, color:Color(0xFF00C853)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            )
                        )
                      ]
                  )
                ]
            )
        )
    );
  }



}
