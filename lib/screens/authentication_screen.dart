import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:
        'https://bimsypyeakxzgigkvcid.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpbXN5cHllYWt4emdpZ2t2Y2lkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NjE5MDMsImV4cCI6MjA1NDQzNzkwM30.hp_I8mRSDSgf4ZfRfNz0TEqJTJQq-jlXnUv_L7Gtglg', // Replace with your Supabase anonymous key
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}

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
        await supabase.auth.signOut();
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