import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player_model.dart';

class PlayerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'players';

  Future<String> addPlayer(Player player) async {
    DocumentReference docRef = await _firestore.collection(collectionName).add(player.toFirestore());
    return docRef.id;
  }

  Stream<List<Player>> getPlayersBySector(String sector) {
    return _firestore
        .collection(collectionName)
        .where('sector', isEqualTo: sector)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Player.fromFirestore(doc,null)) // Use fromFirestore
            .toList());
  }

  Future<Player?> getPlayerById(String playerId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(collectionName).doc(playerId).get();
    if (snapshot.exists) {
      return Player.fromFirestore(snapshot,null); // Use fromFirestore
    } else {
      return null;
    }
  }

  Future<void> updatePlayer(Player player) async {
    await _firestore
        .collection(collectionName)
        .doc(player.id)
        .update(player.toFirestore()); // Use toFirestore
  }

  Future<void> deletePlayer(String playerId) async {
    await _firestore.collection(collectionName).doc(playerId).delete();
  }
}