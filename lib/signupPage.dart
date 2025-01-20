import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // ฟังก์ชันสำหรับการสมัครสมาชิก
  Future<void> signUp(String email, String password, String confirmPassword, String username, BuildContext context) async {
    try {
      // ตรวจสอบว่ารหัสผ่านตรงกับยืนยันรหัสหรือไม่
      if (password != confirmPassword) {
        _showErrorDialog(context, 'Password and confirm password do not match');
        return;
      }

      // ตรวจสอบว่า email หรือ username มีอยู่ในระบบหรือไม่
      final emailExists = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (emailExists.isNotEmpty) {
        _showErrorDialog(context, 'Email is already registered');
        return;
      }

      final usernameExists = await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).get();
      if (usernameExists.docs.isNotEmpty) {
        _showErrorDialog(context, 'Username is already taken');
        return;
      }

      // สร้างบัญชีผู้ใช้ใหม่
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // บันทึกข้อมูลผู้ใช้ใน Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context);  // ปิดหน้าลงทะเบียนและกลับไปที่หน้า login
      print('User signed up and data saved');
    } catch (e) {
      print('Error signing up: $e');
      _showErrorDialog(context, e.toString());
    }
  }

  // ฟังก์ชันสำหรับแสดง Dialog เมื่อเกิดข้อผิดพลาด
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
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Sign up"), backgroundColor: Colors.blue[50]),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 550,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sign up',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    signUp(
                      emailController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                      usernameController.text,
                      context,
                    );
                  },
                  child: const Text('Sign up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
