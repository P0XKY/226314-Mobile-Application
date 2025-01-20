import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set a timer to automatically fetch and save data every 5 minutes
  @override
  void initState() {
    super.initState();
    // Set a timer to run fetchDataAndSave every 5 minutes (300 seconds)
    Timer.periodic(Duration(minutes: 5), (Timer t) {
      fetchDataAndSave();
    });

    // Run it once when the app starts
    fetchDataAndSave();
  }

  // Fetch and save data to Firestore
  Future<void> fetchDataAndSave() async {
    try {
      var data = await fetchAirQualityData();
      saveDataToFirestore(data);
    } catch (e) {
      print("Error: $e");
    }
  }

  // Fetch air quality data from IQAir API
  Future<Map<String, dynamic>> fetchAirQualityData() async {
    final response = await http.get(
      Uri.parse('http://api.airvisual.com/v2/city?city=Mae Ka&state=Phayao&country=Thailand&key=274c95bd-2bb3-448f-b915-03477f596c5d'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server does not return a 200 OK response, throw an exception.
      throw Exception('Failed to load air quality data');
    }
  }

  // Save air quality data to Firestore
  void saveDataToFirestore(Map<String, dynamic> data) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a document in Firestore collection "air_quality"
    firestore.collection('air_quality').add({
      'city': data['data']['city'],
      'state': data['data']['state'],
      'country': data['data']['country'],
      'aqi': data['data']['current']['pollution']['aqius'],
      'temperature': data['data']['current']['weather']['tp'],
      'humidity': data['data']['current']['weather']['hu'],
      'pressure': data['data']['current']['weather']['pr'],
      'timestamp': FieldValue.serverTimestamp(),  // Save timestamp automatically
    }).then((_) {
      print("Data saved successfully to Firestore");
    }).catchError((error) {
      print("Failed to save data to Firestore: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Quality Monitoring',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Air Quality Data'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: fetchDataAndSave,
            child: Text('Manually Fetch and Save Data'),
          ),
        ),
      ),
    );
  }
}
