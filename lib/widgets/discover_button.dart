import 'package:flutter/material.dart';

class DiscoverButton extends StatelessWidget {
  final Color defaultColor;
  final VoidCallback onPressed;

  const DiscoverButton({
    super.key,
    required this.defaultColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            defaultColor,
            defaultColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: defaultColor.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore,
              color: Colors.white,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              "Discover Places",
              style: TextStyle(
                fontSize: 18,
              
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
