import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String? id; // Make id nullable
  final String? name; //Name can be nullable in case of a failure
  final String? sector; //Name can be nullable in case of a failure
  final String? subsector;
  final DateTime? birthdate; //birthdate can be nullable
  final bool? paymentStatus; //paymentStatus can be nullable
  final DateTime? lastPaymentDate; //lastPaymentDate can be nullable
  final DateTime? nextRenewalDate; //nextRenewalDate can be nullable
  final String? qrCode; //qrCode can be nullable

  Player({
    this.id, // id is now optional
    required this.name,
    required this.sector,
    this.subsector,
    required this.birthdate,
    required this.paymentStatus,
    required this.lastPaymentDate,
    required this.nextRenewalDate,
    required this.qrCode,
  });

  factory Player.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return Player(
      id: snapshot.id, // Get ID from document snapshot
      name: data?['name'],
      sector: data?['sector'],
      subsector: data?['subsector'],
      birthdate: (data?['birthdate'] as Timestamp).toDate(), // Convert Timestamp
      paymentStatus: data?['paymentStatus'],
      lastPaymentDate: (data?['lastPaymentDate'] as Timestamp).toDate(),
      nextRenewalDate: (data?['nextRenewalDate'] as Timestamp).toDate(),
      qrCode: data?['qrCode'],
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
    };
  }
}