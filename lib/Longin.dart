import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 430,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sing in',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
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
                  onPressed: () {},
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
                    child: const Text('Sing up'),
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

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          width: 350,
          height: 600,
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
                'Sing up',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
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
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                        MaterialPageRoute(builder: (context) => const LoginPage()),
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