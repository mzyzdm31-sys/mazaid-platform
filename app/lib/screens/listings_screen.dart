import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing.dart';

class ListingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('الإعلانات')),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('listings').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) return Center(child: Text('لا توجد إعلانات بعد'));
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final listing = Listing.fromMap(docs[index].data() as Map<String, dynamic>, docs[index].id);
                return ListTile(
                  leading: listing.imageUrl != null ? Image.network(listing.imageUrl!, width: 64, height: 64, fit: BoxFit.cover) : Icon(Icons.directions_car),
                  title: Text(listing.title),
                  subtitle: Text('${listing.price} ر.س'),
                  onTap: () {
                    // TODO: افتح صفحة تفاصيل
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/new-listing'),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
