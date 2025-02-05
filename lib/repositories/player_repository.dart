import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player_model.dart';

class PlayerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPlayer(Player player) async {
    await _firestore.collection('users').doc(player.id).set(player.toMap());
  }

  Stream<List<Player>> getPlayersBySector(String sector) {
    return _firestore
        .collection('users')
        .where('sector', isEqualTo: sector)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Player.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}

