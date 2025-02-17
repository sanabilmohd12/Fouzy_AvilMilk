import 'package:flutter/material.dart';
import 'package:fouzy/constants/colors.dart';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double barHeight = 300;
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,barHeight/10),
          painter: BNBCustomPainter(),
        ),
        Center(
          heightFactor: .8,
          child: Container(
            height: 120,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 1.7,
                image: AssetImage('assets/Sundae (1).png'),
              ),
              shape: BoxShape.circle,
              color: cYellow,
              boxShadow: [
                BoxShadow(color: cgreen, spreadRadius: 5, blurRadius: 10),
              ],
            ),
          ),
        ),
        Container(
          height: barHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home, 0),
              buildNavItem(Icons.shopping_cart, 1),
              SizedBox(width: 40), // The dummy child for the floating button
              buildNavItem(Icons.edit_document, 2),
              buildNavItem(Icons.auto_graph_outlined, 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        width: 90,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIndex == index ? Colors.white : Colors.transparent,
        ),
        child: Icon(
          size: 35,
          icon,
          color: selectedIndex == index ? Colors.green : Colors.black,
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = cYellow
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 30); // Start
    path.quadraticBezierTo(size.width * .20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


