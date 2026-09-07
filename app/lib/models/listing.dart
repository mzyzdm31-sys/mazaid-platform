class Listing {
  final String id;
  final String title;
  final double price;
  final String? imageUrl;

  Listing({required this.id, required this.title, required this.price, this.imageUrl});

  factory Listing.fromMap(Map<String, dynamic> map, String id) {
    return Listing(
      id: id,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'price': price,
        'imageUrl': imageUrl,
      };
}
