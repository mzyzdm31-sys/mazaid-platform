import 'package:cloud_firestore/cloud_firestore.dart';

class AuctionService {
  final _col = FirebaseFirestore.instance.collection('auctions');

  Future<String> createAuction(Map<String, dynamic> data) async {
    final doc = await _col.add(data);
    return doc.id;
  }

  Stream<QuerySnapshot> listenBids(String auctionId) => _col.doc(auctionId).collection('bids').orderBy('amount', descending: true).snapshots();

  Future<void> placeBid(String auctionId, Map<String, dynamic> bid) async {
    // In production: use transactions / cloud functions to validate
    await _col.doc(auctionId).collection('bids').add(bid);
  }
}
