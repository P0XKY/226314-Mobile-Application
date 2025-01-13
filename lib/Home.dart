import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Center(
          child: Column(
            children: [
              box1('40\n ดี',350.0,200.0,Colors.greenAccent),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,5.0,20.0,10),
                child: Row(
                  children: [
                    box('  PM 2.5\n4.9 µg/m³',100.0,100.0,Colors.white),
                    box('Temperature\n\t\t\t\t\t\t32 °C',100.0,100.0,Colors.pink),
                    box('Humidity\n\t\t\t\t52 %',100.0,100.0,Colors.blueAccent),

                  ],
                ),
              ),
              Text("อัปเดตล่าสุด 1 มกราคม 2025"),
              Text("เวลา 15:00 น."),
              Text("ตำแนะนำ"),
              box2('คุณภาพอากาศน่าพึงพอใจและไม่มีความเสี่ยง ',350.0,200.0,Colors.greenAccent),
            ],
          ),
        )
    );
  }
  Widget box1(text,w,h,color){
    return Container(
      margin: const EdgeInsets.all(20),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text, textScaler: const TextScaler.linear(1.0),style: const TextStyle(color: Colors.black)),
    );
  }

  Widget box2(text,w,h,color){
    return Container(
      margin: const EdgeInsets.all(20),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text, textScaler: const TextScaler.linear(1.0),style: const TextStyle(color: Colors.black)),
    );
  }

  Widget box(text,w,h,color){
    return Container(
      margin: const EdgeInsets.all(11.9),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(text, textScaler: const TextScaler.linear(1.0),style: const TextStyle(color: Colors.black)),
    );
  }

}

