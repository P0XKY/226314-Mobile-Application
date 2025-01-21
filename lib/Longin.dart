import 'package:application/login/LoginPhayaoAirPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ForgotPage.dart';
import 'signupPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> signIn(String username, String password, BuildContext context) async {
    try {
      // ค้นหาจาก Firestore โดยใช้ username เพื่อหา email ที่สัมพันธ์กัน
      var userDoc = await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: username).get();

      if (userDoc.docs.isNotEmpty) {
        // ถ้ามี user ที่ตรงกับ username, ใช้ email ของเขาในการเข้าสู่ระบบ
        String email = userDoc.docs.first['email'];  // ดึง email จาก Firestore

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,  // ใช้ email แทน username
          password: password,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPhayaoAirPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username not found')),
        );
      }
    } catch (e) {
      print('Error signing in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Sign in"), backgroundColor: Colors.blue[50]),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 430,
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
                'Sign in',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,  // ใช้ username แทน email
                decoration: InputDecoration(
                  labelText: 'Username',  // เปลี่ยนจาก 'Email' เป็น 'Username'
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
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPage()),
                    );
                  },
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    signIn(usernameController.text, passwordController.text, context);
                  },
                  child: const Text('Log in'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
