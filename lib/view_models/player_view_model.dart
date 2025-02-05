import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../repositories/player_repository.dart';

class PlayerViewModel with ChangeNotifier {
  final PlayerRepository _repository = PlayerRepository();
  List<Player> _players = [];

  List<Player> get players => _players;

  Future<void> fetchPlayersBySector(String sector) async {
    _players = await _repository.getPlayersBySector(sector).first;
    notifyListeners();
  }

  Future<void> addPlayer(Player player) async {
    await _repository.addPlayer(player);
    notifyListeners();
  }
}