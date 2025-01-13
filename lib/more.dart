import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phayao Air',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AdditionalPage(),
    );
  }
}

class AdditionalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phayao Air'),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.blue),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize:const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Remove the background container here
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            // Removed the color property
            child: const Row(
              children: [
                Text(
                  'ข้อมูลเพิ่มเติม',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('ข้อมูล AQI'),
            leading: const Icon(Icons.air, color: Colors.blue),  // Added color here
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AQIPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('การตั้งค่าการแจ้งเตือน'),
            leading: const Icon(Icons.notifications, color: Colors.orange),  // Added color here
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              // Navigate to the notification settings page (to be created)
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('ข้อมูลติดต่อ'),
            leading: const Icon(Icons.contact_phone, color: Colors.purple),  // Added color here
            trailing: const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title:const Text('เกี่ยวกับ'),
            leading:const Icon(Icons.info_outline, color: Colors.red),  // Added color here
            trailing:const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              // Navigate to the About page (to be created)
            },
          ),
          const Divider(),
          ListTile(
            title:const Text('คู่มือการใช้งาน'),
            leading:const Icon(Icons.book, color: Colors.teal),  // Added color here
            trailing:const Icon(Icons.arrow_forward, color: Colors.green),  // Added color here
            onTap: () {
              // Navigate to the User Guide page (to be created)
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.history, color: Colors.blue), label: 'ประวัติ'),
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz, color: Colors.blue), label: 'เพิ่มเติม'),
        ],
        currentIndex: 1,
        onTap: (index) {
          // Handle navigation (if needed)
        },
      ),
    );
  }
}

class AQIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Phayao Air'),
        centerTitle: true,  // Centers the title
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child:const Icon(Icons.person, color: Colors.blue),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize:const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body:const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ข้อมูล AQI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'ดัชนีคุณภาพอากาศของประเทศไทยแบ่งออกเป็น5ระดับ ตั้งแต่ 0 ถึงมากกว่า 200 แต่ละระดับใช้สีแทนผลกระทบต่อสุขภาพ โดยค่าดัชนี 100 หมายถึงมาตรฐานคุณภาพอากาศ หากค่าสูงเกิน 100 แสดงว่ามลพิษทางอากาศเกินมาตรฐาน และอาจเริ่มส่งผลกระทบต่อสุขภาพประชาชนในวันนั้น:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.green),
                  title: Text('0 - 50'),
                  subtitle: Text('คุณภาพอากาศดี เหมาะสำหรับกิจกรรมกลางแจ้ง'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.yellow),
                  title: Text('51 - 100'),
                  subtitle: Text('คุณภาพอากาศปานกลาง สำหรับผู้ที่มีโรคประจำตัว'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.orange),
                  title: Text('101 - 150'),
                  subtitle: Text('ควรหลีกเลี่ยงกิจกรรมกลางแจ้งสำหรับผู้ป่วย'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.red),
                  title: Text('151 - 200'),
                  subtitle: Text('ไม่เหมาะสำหรับกิจกรรมกลางแจ้งทุกกลุ่ม'),
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.purple),
                  title: Text('มากกว่า 200'),
                  subtitle: Text('อันตรายต่อสุขภาพอย่างมาก'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'ประวัติ'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'เพิ่มเติม'),
        ],
        currentIndex: 1,
        onTap: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Phayao Air'),
        centerTitle: true,  // Centers the title
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child:const Icon(Icons.person, color: Colors.blue),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize:const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body:const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ข้อมูลติดต่อ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'กรมอนามัย กระทรวงสาธารณสุข',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Items under กรมอนามัย กระทรวงสาธารณสุข
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text('ที่อยู่'),
              subtitle: Text('88/22 หมู่ 4 ถนนติวานนท์'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('โทรศัพท์'),
              subtitle: Text('0-2590-4345'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.orange),
              title: Text('อีเมล'),
              subtitle: Text('hiadoh@gmail.com'),
            ),
            SizedBox(height: 16),
            Text(
              'โรงพยาบาลพะเยาราม',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Items under โรงพยาบาลพะเยา ราม
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text('ที่อยู่'),
              subtitle: Text('88/22 หมู่ 4 ถนนติวานนท์'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.purple),
              title: Text('โทรศัพท์'),
              subtitle: Text('054-411111-14'),
            ),
            ListTile(
              leading: Icon(Icons.facebook, color: Colors.blueAccent),
              title: Text('Facebook'),
              subtitle: Text('โรงพยาบาลพะเยา ราม'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'ประวัติ'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'เพิ่มเติม'),
        ],
        currentIndex: 1,
        onTap: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
