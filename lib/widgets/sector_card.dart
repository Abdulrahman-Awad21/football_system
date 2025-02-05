import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/player_view_model.dart';
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
          context.read<PlayerViewModel>().fetchPlayersBySector(sectorName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SectorDetailsScreen(sectorName: sectorName),  // Use SectorDetailsScreen
            ),
          );
        },
      ),
    );
  }
}