import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Widget? nextPage;
  final VoidCallback? onPressed;
  final String label;
  final EdgeInsetsGeometry margin;
  final Color color;

  const NextButton({
    super.key,
    this.nextPage,
    this.onPressed,
    this.label = 'ถัดไป',
    this.margin = const EdgeInsets.fromLTRB(16, 0, 16, 24),
    this.color = Colors.grey,
  }) : assert(nextPage != null || onPressed != null,
            'Either nextPage or onPressed must be provided');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: margin,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
                return;
              }
              if (nextPage != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage!),
                );
              }
            },
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
