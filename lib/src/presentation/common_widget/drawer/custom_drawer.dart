import 'dart:math';

import 'package:flutter/material.dart';

import 'content_drawer.dart';


class CustomDrawer extends StatefulWidget {
  final Widget child;

  const CustomDrawer({Key? key, required this.child}) : super(key: key);

  static CustomDrawerState? of(BuildContext context) =>
      context.findAncestorStateOfType<CustomDrawerState>();

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    _animationController.isCompleted
        ? close()
        : open();
  }

  void close() {
    _animationController.reverse();
  }

  void open() {


    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          if (_animationController.isCompleted) {
            close();
            return false;
          }
          return true;
        },
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(
                        MediaQuery.of(context).size.width *
                            0.8 *
                            (_animationController.value - 1),
                        0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(pi / 2 * (1 - _animationController.value)),
                      alignment: Alignment.centerRight,
                      child: const ContentDrawer(),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        MediaQuery.of(context).size.width *
                            0.8 *
                            _animationController.value,
                        0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-pi * (_animationController.value) / 2),
                      alignment: Alignment.centerLeft,
                      child: widget.child,
                    ),
                  ),
                  Positioned(
                    top:  MediaQuery.of(context).padding.top+7,
                    left: _animationController.value *
                        (MediaQuery.of(context).size.width - paddingRight),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: _animationController.value == 0 ? 8 : 0,
                      ),
                      child: IconButton(
                        onPressed: toggleDrawer,
                        icon: AnimatedIcon(
                          progress: _animationController,
                          icon: AnimatedIcons.menu_close,
                          size: 26,
                          color: _animationController.value == 0
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

}

const paddingRight = 60;
