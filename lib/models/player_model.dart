class Player {
  final String id;
  final String name;
  final String sector;
  final String? subsector;
  final DateTime birthdate;
  final bool paymentStatus;
  final DateTime lastPaymentDate;
  final DateTime nextRenewalDate;
  final String qrCode;

  Player({
    required this.id,
    required this.name,
    required this.sector,
    this.subsector,
    required this.birthdate,
    required this.paymentStatus,
    required this.lastPaymentDate,
    required this.nextRenewalDate,
    required this.qrCode,
  });

  factory Player.fromMap(Map<String, dynamic> data) {
    return Player(
      id: data['id'],
      name: data['name'],
      sector: data['sector'],
      subsector: data['subsector'],
      birthdate: data['birthdate'].toDate(),
      paymentStatus: data['paymentStatus'],
      lastPaymentDate: data['lastPaymentDate'].toDate(),
      nextRenewalDate: data['nextRenewalDate'].toDate(),
      qrCode: data['qrCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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