// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:amateurs/screens/authentication_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: "https://bimsypyeakxzgigkvcid.supabase.co",
//     anonKey:
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpbXN5cHllYWt4emdpZ2t2Y2lkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NjE5MDMsImV4cCI6MjA1NDQzNzkwM30.hp_I8mRSDSgf4ZfRfNz0TEqJTJQq-jlXnUv_L7Gtglg",
//   );

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Auth UI',
//       home: AuthScreen(),
//     );
//   }
// }
import 'package:amateurs/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:amateurs/screens/user_signup.dart';

void main() {
  runApp(const UserLogin());
}
