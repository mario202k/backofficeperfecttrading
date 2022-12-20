import 'package:flutter/material.dart';

class AnimatedAppear extends StatefulWidget {
  final List<Widget> children;
  final bool isForward;
  final double heightOfOneItem;

  const AnimatedAppear(
      {required this.children,
      this.isForward = true,
      required this.heightOfOneItem,
      Key? key})
      : super(key: key);

  @override
  State<AnimatedAppear> createState() => _AnimatedAppearState();
}

class _AnimatedAppearState extends State<AnimatedAppear>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.isForward) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    return Flow(
      delegate: FlowMenuDelegate(
          animationController: _animationController,
          heightOfOneItem: widget.heightOfOneItem),
      children: widget.children,
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final AnimationController animationController;
  final double heightOfOneItem;

  FlowMenuDelegate({
    required this.animationController,
    required this.heightOfOneItem,
  }) : super(repaint: animationController);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;

    final xStart = size.width / 2;
    final yStart = -size.height / 2+heightOfOneItem/2 ;

    const margin = 0;
    final animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut));

    for (int i = context.childCount - 1; i >= 0; i--) {
      final childSize = context.getChildSize(i);

      if (childSize == null) {
        continue;
      }

      final dy = yStart + (margin + heightOfOneItem) * (i) * animation.value;

      context.paintChild(i,
          transform: Matrix4.translationValues(
              xStart - childSize.width * 0.5, dy.toDouble(), 0),
          opacity: animation.value);
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
