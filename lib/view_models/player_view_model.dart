import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../repositories/player_repository.dart';
import 'dart:io';

class PlayerViewModel with ChangeNotifier {
  final PlayerRepository _repository = PlayerRepository();
  List<Player> _players = [];

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