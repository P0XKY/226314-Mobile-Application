import 'package:flutter/material.dart';

import 'Longin.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 450,
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
                'Reset Password',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Confirm'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text('Sing in'),
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