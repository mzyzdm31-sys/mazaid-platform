import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewListingScreen extends StatefulWidget {
  @override
  _NewListingScreenState createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final doc = {
      'title': _title.text.trim(),
      'price': double.tryParse(_price.text.trim()) ?? 0,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('listings').add(doc);
    setState(() => _loading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('إضافة إعلان')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(labelText: 'عنوان الإعلان'),
                  validator: (v) => v == null || v.isEmpty ? 'الرجاء إدخال عنوان' : null,
                ),
                TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'السعر'),
                  validator: (v) => v == null || v.isEmpty ? 'الرجاء إدخال السعر' : null,
                ),
                SizedBox(height: 12),
                _loading ? CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: Text('نشر الإعلان'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
