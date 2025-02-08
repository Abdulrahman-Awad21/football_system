import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../models/player_model.dart';

class PlayerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'players';

  Future<String> uploadImage(File image, String playerId) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('player_photos')
        .child('$playerId.jpg');

    firebase_storage.UploadTask uploadTask = ref.putFile(image);

    await uploadTask.whenComplete(() => null);

    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> addPlayer(Player player, File? image) async {
    DocumentReference docRef = await _firestore.collection(collectionName).add(player.toFirestore());
    if (image != null) {
      String imageUrl = await uploadImage(image, docRef.id);
      await _firestore.collection(collectionName).doc(docRef.id).update({'imageUrl': imageUrl});
    }
    return docRef.id;
  }

  Stream<List<Player>> getPlayersBySector(String sector) {
    return _firestore
        .collection(collectionName)
        .where('sector', isEqualTo: sector)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Player.fromFirestore(doc,null))
            .toList());
  }

  Future<Player?> getPlayerById(String playerId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(collectionName).doc(playerId).get();
    if (snapshot.exists) {
      return Player.fromFirestore(snapshot,null);
    } else {
      return null;
    }
  }

  Future<void> updatePlayer(Player player) async {
    await _firestore
        .collection(collectionName)
        .doc(player.id)
        .update(player.toFirestore());
  }

  Future<void> deletePlayer(String playerId) async {
    await _firestore.collection(collectionName).doc(playerId).delete();
  }
}