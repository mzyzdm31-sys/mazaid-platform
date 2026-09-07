class Auction {
  final String id;
  final String listingId;
  final DateTime startsAt;
  final DateTime endsAt;
  final double startingPrice;

  Auction({required this.id, required this.listingId, required this.startsAt, required this.endsAt, required this.startingPrice});

  factory Auction.fromMap(Map<String, dynamic> map, String id) {
    return Auction(
      id: id,
      listingId: map['listingId'] ?? '',
      startsAt: (map['startsAt'] as Timestamp).toDate(),
      endsAt: (map['endsAt'] as Timestamp).toDate(),
      startingPrice: (map['startingPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'listingId': listingId,
        'startsAt': startsAt,
        'endsAt': endsAt,
        'startingPrice': startingPrice,
      };
}
