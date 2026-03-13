import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasEmptyScreen extends StatelessWidget {
  const NeoKelasEmptyScreen({
    super.key,
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: 32.all,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeoKelasContainer(
              width: 64,
              height: 64,
              padding: EdgeInsets.zero,
              child: Icon(
                icon,
                size: 28,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            Text(
              message,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ].separatedBy(16.h),
        ),
      ),
    );
  }
}
