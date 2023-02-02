import 'package:flutter/material.dart';

class AppSnackBar {
  static show({
    required String message,
    required BuildContext context,
    bool error = false,
  }) {
    var snackColor = Theme.of(context).colorScheme.inverseSurface;

    if (error) {
      snackColor = Theme.of(context).colorScheme.error;
    }

    var snack = SnackBar(
      backgroundColor: snackColor,
      content: Row(
        children: [
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              message,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
