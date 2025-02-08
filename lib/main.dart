import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amateurs/project/routes/app_route_config.dart';
import "package:go_router/go_router.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bimsypyeakxzgigkvcid.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpbXN5cHllYWt4emdpZ2t2Y2lkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NjE5MDMsImV4cCI6MjA1NDQzNzkwM30.hp_I8mRSDSgf4ZfRfNz0TEqJTJQq-jlXnUv_L7Gtglg',
  );

  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

  final router = MyAppRouter.returnRouter(accessToken != null);

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
