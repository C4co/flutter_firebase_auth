import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Starter'),
        actions: [
          if (user?.photoURL == null)
            IconButton(
              onPressed: () {
                context.go('/home/user');
              },
              icon: const Icon(Icons.person),
            ),
          if (user?.photoURL != null)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('/home/user');
                  },
                  child: CircleAvatar(
                    radius: 16,
                    child: ClipOval(child: Image.network('${user?.photoURL}')),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
        ],
      ),
      body: const Center(
        child: Text(
          '🍎',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
