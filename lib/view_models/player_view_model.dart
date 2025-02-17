import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../repositories/player_repository.dart';
import 'dart:io';

class PlayerViewModel with ChangeNotifier {
  final PlayerRepository _repository = PlayerRepository();
  String? _currentSector;
  List<Player> _players = [];

  // List<Player> get players => _players; //Remove this line

   //   List<Player> get_players ( String sectorName ) {
  //   List<Player> playerList= [];
  //   db.collection("players").get().then(
  //   (querySnapshot) {
  //     print("Successfully completed");  
  //     for (var docSnapshot in querySnapshot.docs) {
  //       // print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       Player p =  Player(
  //         id: docSnapshot.id,
  //         name: docSnapshot.get('name'),
  //         sector: docSnapshot.get('sector'),
  //         subsector: docSnapshot.get('subsector'),
  //         birthdate: docSnapshot.get('birthdate').toDate(),
  //         paymentStatus: docSnapshot.get('paymentStatus'),
  //         lastPaymentDate: docSnapshot.get('lastPaymentDate').toDate(),
  //         nextRenewalDate: docSnapshot.get('nextRenewalDate').toDate(),
  //         qrCode: docSnapshot.get('qrCode'),
  //         imageUrl: docSnapshot.get('imageUrl'),
  //       );
  //       playerList.add(p);
  //     }
  //   },
  //   onError: (e) => print("Error completing: $e"),
  // );    
  //   return  playerList;
  // }

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