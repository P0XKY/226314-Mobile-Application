import 'package:flutter/material.dart';

import 'ResetPage.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 220,
          padding: const EdgeInsets.all(15.15), // ระยะห่างภายในกล่อง
          decoration: BoxDecoration(
            color: Colors.white, // สีพื้นหลังของกล่อง
            borderRadius: BorderRadius.circular(16.0), // มุมโค้ง
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // เงา
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3), // ตำแหน่งเงา
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Reset Your Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPage()),
                    );
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}