import 'package:application/ForgotPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('โปรไฟล์', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser?.uid) // Use the logged-in user's UID
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('ไม่มีข้อมูลผู้ใช้'));
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                // รูปโปรไฟล์
                // Center(
                //   child: Container(
                //     margin: const EdgeInsets.all(16.0),
                //     width: 120.0,
                //     height: 120.0,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //         image: NetworkImage(userData['profilePicture'] ?? 'https://via.placeholder.com/120'), // URL รูป
                //         fit: BoxFit.cover,
                //       ),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5),
                //           spreadRadius: 2,
                //           blurRadius: 8,
                //           offset: const Offset(0, 4),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // ข้อมูลส่วนตัว
                const Text(
                  'ข้อมูลส่วนตัว',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text('ชื่อผู้ใช้: ${userData['username'] ?? 'N/A'}'),
                  leading: const Icon(Icons.person, color: Colors.blue),
                ),
                const Divider(),
                ListTile(
                  title: Text('อีเมล: ${userData['email'] ?? 'N/A'}'),
                  leading: const Icon(Icons.email, color: Colors.orange),
                ),
                const Divider(),
                ListTile(
                  title: const Text('เปลี่ยนรหัสผ่าน'),
                  leading: const Icon(Icons.lock, color: Colors.red),
                  trailing: const Icon(Icons.arrow_forward, color: Colors.green),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPage()),
                    );
                  },
                ),
                const Divider(),
                // ปุ่มสำหรับ logout
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushNamed(context, '/Login');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
