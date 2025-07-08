import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy profile info
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 48)),
            SizedBox(height: 16),
            Text('Nama User', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('user@email.com'),
          ],
        ),
      ),
    );
  }
}
