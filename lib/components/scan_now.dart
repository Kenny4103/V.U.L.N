import 'package:flutter/material.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:vuln/pages/scan_page.dart';

class NeonButt2 extends StatelessWidget {
  const NeonButt2(this.wording, {super.key});
  final String wording;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: NeumorphicButton(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ScanPage()));
          },
          borderRadius: 20,
          bottomRightShadowBlurRadius: 10,
          bottomRightShadowSpreadRadius: 1,
          borderWidth: 5,
          backgroundColor: Colors.amber.shade700.withOpacity(0.45),
          topLeftShadowBlurRadius: 15,
          topLeftShadowSpreadRadius: 1,
          topLeftShadowColor: Colors.black54,
          bottomRightShadowColor: Colors.amber.shade700.withOpacity(0.9),
          height: size.width * 0.35, // Adjust the height
          width: size.width * 0.6, // Adjust the width
          padding: const EdgeInsets.all(20), // Adjust the padding
          bottomRightOffset: const Offset(4, 4),
          topLeftOffset: const Offset(-4, -4),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              wording,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 10,
                    color: Colors.black54,
                  ),
                ],
                letterSpacing: 4,
                fontSize: 28, // Adjust the font size
                color: Colors.white,
                fontFamily: 'Young_Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}