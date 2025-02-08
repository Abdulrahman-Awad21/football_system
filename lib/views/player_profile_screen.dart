import 'package:flutter/material.dart';

class PlayerProfileScreen extends StatelessWidget {
  final String playerId;

  PlayerProfileScreen({required this.playerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player Profile')),
      body: Center(
        child: Text('Player ID: $playerId'),
      ),
    );
  }
}