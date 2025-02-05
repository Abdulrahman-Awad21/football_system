import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/player_view_model.dart';
import 'add_player_screen.dart';
import '../widgets/sector_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Football Coach App')),
      body: Column(
        children: [
          SectorCard(sectorName: 'Taqadum Nasheen'),
          SectorCard(sectorName: 'Taqadum Braeem'),
          SectorCard(sectorName: 'Smoha Braeem'),
          SectorCard(sectorName: 'Academy'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPlayerScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}