import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user?.displayName == null ? '${user?.email}' : '${user?.displayName}',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure to leave the application'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (mounted) {
                          context.go('/');
                        }
                      },
                      child: const Text('Yes'),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          // name
          if (user?.displayName != null)
            Wrap(
              children: [
                ListTile(
                  title: Text('${user?.displayName}'),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade500,
                ),
              ],
            ),

          // email
          if (user?.email != null)
            Wrap(
              children: [
                ListTile(
                  title: Text('${user?.email}'),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade500,
                ),
              ],
            ),

          // uuid
          if (user?.uid != null)
            Wrap(
              children: [
                ListTile(
                  title: Text('${user?.uid}'),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
