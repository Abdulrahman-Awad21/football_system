import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../repositories/player_repository.dart';
import 'dart:io';

class PlayerViewModel with ChangeNotifier {
  final PlayerRepository _repository = PlayerRepository();
  String? _currentSector;
  List<Player> _players = [];

  // List<Player> get players => _players; //Remove this line
   List<Player> get players {
    if (_currentSector == null) {
      return []; // Or handle this case as you see fit (e.g., show a loading indicator)
    }
    return _players;
  }

  Future<void> fetchPlayersBySector(String sector) async {
    _currentSector = sector;
    _players = await _repository.getPlayersBySector(sector).first;
    notifyListeners();
  }


  Future<String> addPlayer(Player player,File? image) async {
    String playerId = await _repository.addPlayer(player,image);
    notifyListeners();
    return playerId;
  }

  Future<void> markAttendance(String playerId) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year,now.month,now.day);
    await _repository.markAttendance(playerId,today);
    await fetchPlayersBySector(_players.first.sector!);
    notifyListeners();
  }

  Future<void> removeAttendance(String playerId) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year,now.month,now.day);
    await _repository.removeAttendance(playerId,today);
    await fetchPlayersBySector(_players.first.sector!);
    notifyListeners();
  }

  Future<Player?> getPlayer(String playerId) async {
    return await _repository.getPlayerById(playerId);
  }

    String? get currentSector => _currentSector;

  set currentSector(String? value) {
    _currentSector = value;
  }
}