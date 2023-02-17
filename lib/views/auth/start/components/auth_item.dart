import 'package:flutter/material.dart';

class AuthOption extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;
  final String label;

  const AuthOption({
    super.key,
    required this.action,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      title: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 20),
          Text(label),
        ],
      ),
    );
  }
}
