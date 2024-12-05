import 'package:flutter/material.dart';
import 'package:untitled/screens/welcome_screen.dart';
import 'dart:convert'; // For JSON decoding
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter/material.dart'; // Flutter material package

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> users = []; // To store parsed JSON data

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      // Load the JSON file as a string
      String jsonString = await rootBundle.loadString('assets/users.json');
      // Decode the JSON string
      final List<dynamic> jsonResponse = json.decode(jsonString);
      setState(() {
        users = jsonResponse;
      });
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: users.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loader until data is loaded
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  child: ListTile(
                    title: Text(user['userName']),
                    subtitle: Text(user['email']),
                    trailing: Text('ID: ${user['id']}'),
                  ),
                );
              },
            ),
    );
  }
}
