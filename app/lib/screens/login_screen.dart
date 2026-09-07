import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;
  bool _codeSent = false;
  bool _loading = false;

  final AuthService _authService = AuthService();

  void _sendCode() async {
    setState(() => _loading = true);
    await _authService.sendOtp(_phoneController.text.trim(), (verificationId) {
      setState(() {
        _verificationId = verificationId;
        _codeSent = true;
        _loading = false;
      });
    }, (err) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.message ?? 'خطأ في المصادقة')));
    });
  }

  void _verifyCode() async {
    setState(() => _loading = true);
    try {
      await _authService.verifyOtp(_verificationId!, _codeController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('رمز غير صحيح')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('تسجيل الدخول')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'رقم الجوال (مع رمز الدولة)') ,
              ),
              SizedBox(height: 12),
              if (_codeSent) ...[
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'رمز التحقق (OTP)'),
                ),
                SizedBox(height: 12),
              ],
              SizedBox(height: 12),
              _loading ? CircularProgressIndicator() : ElevatedButton(
                onPressed: _codeSent ? _verifyCode : _sendCode,
                child: Text(_codeSent ? 'تأكيد الرمز' : 'إرسال رمز'),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  // TODO: Google/Email Sign in flows (placeholders)
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تسجيل عبر Google/Email قادم')));
                },
                child: Text('تسجيل عبر Google / Email'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
