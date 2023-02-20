import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool loading;
  final bool fullWidth;
  final bool hidden;

  const AppButton({
    super.key,
    this.onPressed,
    required this.label,
    this.loading = false,
    this.fullWidth = false,
    this.hidden = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    var width = widget.fullWidth ? double.infinity : null;

    if (widget.hidden) {
      return const SizedBox(width: 0, height: 0);
    }

    if (widget.loading) {
      return FilledButton(
        onPressed: null,
        child: SizedBox(
          width: width,
          child: const Column(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ],
          ),
        ),
      );
    }

    return FilledButton(
      onPressed: widget.onPressed,
      child: SizedBox(
        width: width,
        child: Center(child: Text(widget.label)),
      ),
    );
  }
}
