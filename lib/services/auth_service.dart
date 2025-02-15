import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user with email, password, and username
  Future<UserCredential?> registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      
      UserCredential? result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          
      
      

      // Check and Create the user
       if (result.user!=null) {
        await result.user!.updateProfile(displayName: username);

        // Store additional user information in Firestore
        await _firestore.collection('Users').doc(result.user!.uid).set({
         'username': username,
         'email': email,
       });
           return result;
       }else{
            print('Firebase Registration Error: User was not generated'); // Log the error
            return null;
        }
    } catch (e) {
      print('Firebase Registration Error: ${e.toString()}'); // Log the error
      
      return null;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Auth change user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}