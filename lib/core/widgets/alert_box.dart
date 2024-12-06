import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatelessWidget {
  final Function onConfirmed;
  final Function onCancel;
  final String message;

  ConfirmationDialog({
    required this.onConfirmed,
    required this.onCancel,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;

    return AlertDialog(
      content: Text(
        message,
        style: GoogleFonts.urbanist(
          fontSize: h * 0.02,
          fontWeight: FontWeight.w600,
          color: Colors.black, // Update color as needed
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => onCancel(),
          child:
          Text(
            'Cancel',
            style: GoogleFonts.urbanist(
              fontSize: h * 0.018,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirmed();
            Navigator.pop(context);
          },
          child:
          Text(
            'Confirm',
            style: GoogleFonts.urbanist(
              fontSize: h * 0.018,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Update color as needed
            ),
          ),
        ),
      ],
    );
  }
}
