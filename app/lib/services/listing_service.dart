import 'package:cloud_firestore/cloud_firestore.dart';

class ListingService {
  final _col = FirebaseFirestore.instance.collection('listings');

  Stream<QuerySnapshot> getListingsStream() => _col.orderBy('createdAt', descending: true).snapshots();

  Future<String> createListing(Map<String, dynamic> data) async {
    final doc = await _col.add(data);
    return doc.id;
  }

  Future<void> updateListing(String id, Map<String, dynamic> data) async {
    await _col.doc(id).update(data);
  }

  Future<void> deleteListing(String id) async {
    await _col.doc(id).delete();
  }
}
