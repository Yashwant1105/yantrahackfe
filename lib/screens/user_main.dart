import 'package:flutter/material.dart';

class UserMain extends StatelessWidget {
  const UserMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('User Main Screen'),
        ),
      ),
    );
  }
}
