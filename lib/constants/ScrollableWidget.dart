import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final Widget child;

  var horizontalScrollCT = ScrollController();
  var verticalScrollCT = ScrollController();

  ScrollableWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: horizontalScrollCT,
    thumbVisibility: true,
    thickness: 14,
    child: SingleChildScrollView(
      controller: horizontalScrollCT,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Scrollbar(
        controller: verticalScrollCT,
        scrollbarOrientation: ScrollbarOrientation.left,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: verticalScrollCT,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: child,
        ),
      ),
    ),
  );
}