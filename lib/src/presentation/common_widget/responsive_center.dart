import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';

/// Reusable widget for showing a child with a maximum content width constraint.
/// If available width is larger than the maximum width, the child will be
/// centered.
/// If available width is smaller than the maximum width, the child use all the
/// available width.
class ResponsivePaddingCenter extends StatelessWidget {
  const ResponsivePaddingCenter({
    super.key,
    this.maxContentWidth = 800,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Use Center as it has *unconstrained* width (loose constraints)
    final width = MediaQuery.of(context).size.width;

    final padding24 = (width / refWidth) * 16;

    final padding = width > 848
        ? const EdgeInsets.symmetric(
      horizontal: 54,
    )
        : EdgeInsets.symmetric(
            horizontal: padding24,
          );
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
