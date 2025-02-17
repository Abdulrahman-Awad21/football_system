import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      try {
                         await _authService.signInWithEmailAndPassword(email, password);
                        // After signing in, check the current user
                        if (FirebaseAuth.instance.currentUser != null) {
                          // Login Successful
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login successful!')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } else {
                          // Login Failed - even after the function executed, there is no user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login failed. Please check your credentials.')),
                          );
                        }
                      } catch (error) {
                        // Handle unexpected errors
                        print('Error during login: $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred during login. Please try again later.')),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
              child: _isLoading ? CircularProgressIndicator() : Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ]
        ),
      ),
    );
  }
}