class Sector {
  final String id;
  final String name;
  final double paymentPlan;
  final DateTime renewalDate;
  final String playerCategory;

  Sector({
    required this.id,
    required this.name,
    required this.paymentPlan,
    required this.renewalDate,
    required this.playerCategory,
  });

  factory Sector.fromMap(Map<String, dynamic> data) {
    return Sector(
      id: data['id'],
      name: data['name'],
      paymentPlan: data['paymentPlan'],
      renewalDate: data['renewalDate'].toDate(),
      playerCategory: data['playerCategory'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'paymentPlan': paymentPlan,
      'renewalDate': renewalDate,
      'playerCategory': playerCategory,
    };
  }
}