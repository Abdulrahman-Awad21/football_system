// lib/models/player_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String? id;
  final String? name;
  final String? sector;
  final String? subsector;
  final DateTime? birthdate;
  final bool? paymentStatus;
  final DateTime? lastPaymentDate;
  final DateTime? nextRenewalDate;
  final String? qrCode;
  final String? imageUrl;
  List<DateTime> attendance; // Add this line

  Player({
    this.id,
    required this.name,
    required this.sector,
    this.subsector,
    required this.birthdate,
    required this.paymentStatus,
    required this.lastPaymentDate,
    required this.nextRenewalDate,
    required this.qrCode,
    this.imageUrl,
    this.attendance = const [], // Initialize with an empty list
  });

   factory Player.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return Player(
      id: snapshot.id,
      name: data?['name'],
      sector: data?['sector'],
      subsector: data?['subsector'],
      birthdate: (data?['birthdate'] as Timestamp).toDate(),
      paymentStatus: data?['paymentStatus'],
      lastPaymentDate: (data?['lastPaymentDate'] as Timestamp).toDate(),
      nextRenewalDate: (data?['nextRenewalDate'] as Timestamp).toDate(),
      qrCode: data?['qrCode'],
      imageUrl: data?['imageUrl'],
      attendance: data?['attendance'] != null
              ? (data?['attendance'] as List<dynamic>)
                  .map((timestamp) => (timestamp as Timestamp).toDate())
                  .toList()
              : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'sector': sector,
      'subsector': subsector,
      'birthdate': birthdate,
      'paymentStatus': paymentStatus,
      'lastPaymentDate': lastPaymentDate,
      'nextRenewalDate': nextRenewalDate,
      'qrCode': qrCode,
      'imageUrl': imageUrl,
      'attendance': attendance.map((date) => date).toList(), // Store attendance dates

    };
  }
}