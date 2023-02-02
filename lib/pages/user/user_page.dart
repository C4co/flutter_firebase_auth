import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User? user = FirebaseAuth.instance.currentUser;

  leaveApplication(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      context.go('/');
    }
  }

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
              AppDialog.show(
                title: 'Leave',
                context: context,
                content: 'Are you sure to leave the application?',
                actions: [
                  TextButton(
                    onPressed: () {
                      leaveApplication(context);
                    },
                    child: const Text('Yes'),
                  )
                ],
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
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
                const Divider(
                  height: 1,
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
                const Divider(
                  height: 1,
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
                const Divider(
                  height: 1,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
