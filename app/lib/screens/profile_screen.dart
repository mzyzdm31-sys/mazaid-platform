import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('الملف الشخصي')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.phoneNumber ?? user?.email ?? 'مستخدم جديد', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 4),
                      Text('معرّف: ${user?.uid ?? '-'}', style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Text('توثيق الحساب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('حالة التوثيق: غير موثّق', style: TextStyle(color: Colors.orange)),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  // TODO: رفع مستندات التوثيق
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('واجهة رفع المستندات قيد التطوير')));
                },
                icon: Icon(Icons.upload_file),
                label: Text('رفع مستندات التوثيق'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('تسجيل الخروج'),
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
