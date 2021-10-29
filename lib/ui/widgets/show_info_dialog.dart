import 'package:flutter/material.dart';

Future<void> showInfoDialog(BuildContext context, String message) async =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
