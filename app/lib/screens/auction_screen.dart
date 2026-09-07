import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuctionScreen extends StatefulWidget {
  final String auctionId;
  AuctionScreen({required this.auctionId});

  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final TextEditingController _bidController = TextEditingController();
  Stream<QuerySnapshot>? _bidsStream;

  @override
  void initState() {
    super.initState();
    _bidsStream = FirebaseFirestore.instance.collection('auctions').doc(widget.auctionId).collection('bids').orderBy('amount', descending: true).snapshots();
  }

  Future<void> _placeBid() async {
    final amount = double.tryParse(_bidController.text.trim());
    if (amount == null) return;
    // Simple write — in production use transactions/functions to enforce rules
    await FirebaseFirestore.instance.collection('auctions').doc(widget.auctionId).collection('bids').add({
      'amount': amount,
      'createdAt': FieldValue.serverTimestamp(),
      'userId': FirebaseFirestore.instance.app.options.projectId, // placeholder
    });
    _bidController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('المزاد')),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _bidsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final bid = docs[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: Icon(Icons.gavel),
                        title: Text('${bid['amount']} ر.س'),
                        subtitle: Text(bid['userId'] ?? 'مستخدم'),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _bidController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: 'أدخل قيمة المزايدة'))),
                  SizedBox(width: 8),
                  ElevatedButton(onPressed: _placeBid, child: Text('مزايدة'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
