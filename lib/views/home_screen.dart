import 'package:flutter/material.dart';
import 'package:football_system/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'add_player_screen.dart';
import '../widgets/sector_card.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = 'Loading...'; // Initial loading message

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If the display name is available directly from Firebase Auth
      String? displayName = user.displayName;
      String username;

      // If the name exists show it else check it in firestore
      // print("user displayaaaaaaaaaaaaaaaaaa ${user.displayName}");
      if (displayName != null && displayName.isNotEmpty) {
        username = displayName;
      } else {
        try{
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
          
         if (snapshot.exists) {
            username = snapshot.data()?['username'] ?? 'User'; // Check the username in Firestore
          } else {
            username = 'User'; // If the document does not exist, return 'User'
          }
           } catch (e) {
          username = "User";// In case of an error, return a default value
          print('Error getting display name from Firestore : ${e}');
          // print(getCurrentUser())
          }
      }

      setState(() {
        _username = username;
      });
    } else {
      setState(() {
        _username = "Guest"; // Set the default value to "Guest" if the user object is null
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Coach App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              
              await authService.signOut();
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              
            },
          ),
        ],
      ),
      body: Center( // Wrap Column with Center
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome: $_username', // Display welcome message
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SectorCard(sectorName: 'Taqadum Nasheen'),
              SectorCard(sectorName: 'Taqadum Braeem'),
              SectorCard(sectorName: 'Smoha Braeem'),
              SectorCard(sectorName: 'Academy'),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPlayerScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}