import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Longin.dart';  // หน้า LoginPage ที่จะไปหลังจากการรีเซ็ตรหัสผ่านสำเร็จ

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key? key}) : super(key: key);

  // ฟังก์ชันสำหรับส่งลิงก์รีเซ็ตรหัสผ่านไปยังอีเมล
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);  // ส่งลิงก์รีเซ็ตรหัสผ่าน
      _showSuccessDialog(context);  // แสดง Dialog เมื่อส่งลิงก์สำเร็จ
    } catch (e) {
      print('Error sending password reset email: $e');
      _showErrorDialog(context, 'Failed to send password reset email. Please try again.');
    }
  }

  // ฟังก์ชันแสดง Dialog เมื่อการส่งลิงก์สำเร็จ
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('We have sent a password reset link to your email.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),  // ไปที่หน้า LoginPage
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันแสดง Dialog เมื่อเกิดข้อผิดพลาด
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password'), backgroundColor: Colors.blue[50]),
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 220,
          padding: const EdgeInsets.all(15.15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Reset Your Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,  // กำหนดความกว้างของปุ่ม
                child: ElevatedButton(
                  onPressed: () {
                    resetPassword(emailController.text, context);  // ส่งลิงก์รีเซ็ตรหัสผ่าน
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,  // สีพื้นหลังของปุ่ม
                    foregroundColor: Colors.white,  // สีข้อความภายในปุ่ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),  // มุมโค้งของปุ่ม
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),  // ขนาดของปุ่ม (ปรับเพิ่มหรือลด)
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,  // ขนาดตัวอักษร
                      fontWeight: FontWeight.bold,  // หนักตัวอักษร
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
