import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../repositories/player_repository.dart';
import 'dart:io';

class PlayerViewModel with ChangeNotifier {
  final PlayerRepository _repository = PlayerRepository();
  List<Player> _players = [];

  List<Player> get players => _players;

  Future<void> fetchPlayersBySector(String sector) async {
    _players = await _repository.getPlayersBySector(sector).first;
    notifyListeners();
  }

  Future<String> addPlayer(Player player,File? image) async {
    String playerId = await _repository.addPlayer(player,image);
    notifyListeners();
    return playerId;
  }
}