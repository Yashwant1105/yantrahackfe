import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isFactoryLogin = false; // Default is user login

  Future<void> registerUser() async {
    try {
      final authResponse = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {'role': isFactoryLogin ? 'factory' : 'user'},
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registered successfully! Check your email.'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> loginUser() async {
    try {
      final authResponse = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful! Session expires in 1 minute.'),
      ));

      // Schedule logout after 1 minute
      Future.delayed(Duration(minutes: 1), () async {
        await supabase.auth.signOut(); // Logs out user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Session expired! Please log in again.'),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(isFactoryLogin ? 'Factory Login' : 'User Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFactoryLogin = !isFactoryLogin;
                  });
                },
                child: Text(
                  'Are you from a factory?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                  isFactoryLogin ? 'Register as Factory' : 'Register as User'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: loginUser,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child:
                  Text(isFactoryLogin ? 'Login as Factory' : 'Login as User'),
            ),
          ],
        ),
      ),
    );
  }
}
