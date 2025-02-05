import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/player_view_model.dart';
import '../models/player_model.dart';

class SectorDetailsScreen extends StatelessWidget {
  final String sectorName;

  SectorDetailsScreen({required this.sectorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$sectorName Players')),
      body: Consumer<PlayerViewModel>(
        builder: (context, playerViewModel, child) {
          final players = playerViewModel.players
              .where((player) => player.sector == sectorName)
              .toList();

          return ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];
              return ListTile(
                title: Text(player.name),
                subtitle: Text(player.sector),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to player profile screen (to be implemented)
                },
              );
            },
          );
        },
      ),
    );
  }
}