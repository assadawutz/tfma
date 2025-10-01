import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Widget nextPage;
  final String label;
  final EdgeInsetsGeometry margin;
  final Color color;

  const NextButton({
    super.key,
    required this.nextPage,
    this.label = 'ถัดไป',
    this.margin = const EdgeInsets.fromLTRB(16, 0, 16, 24),
    this.color = Colors.grey,
  });

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
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
