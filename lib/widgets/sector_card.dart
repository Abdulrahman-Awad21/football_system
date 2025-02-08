import 'package:flutter/material.dart';
import '../views/sector_details_screen.dart';

class SectorCard extends StatelessWidget {
  final String sectorName;

  SectorCard({required this.sectorName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(sectorName),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SectorDetailsScreen(sectorName: sectorName),
            ),
          );
        },
      ),
    );
  }
}