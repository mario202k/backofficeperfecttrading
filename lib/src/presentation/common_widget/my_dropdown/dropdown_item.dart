import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';

class DropDownItem extends StatefulWidget {
  final String text;
  final bool isFirstItem;
  final bool isLastItem;
  final double width;
  final VoidCallback onTap;
  final double heightOfOneItem;
  final bool isCurrentSelected;

  const DropDownItem(
      {Key? key,
      this.isFirstItem = false,
      this.isLastItem = false,
      required this.text,
      required this.onTap,
      required this.heightOfOneItem,
      required this.width,
      required this.isCurrentSelected})
      : super(key: key);

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  late bool _isHover;

  @override
  void initState() {
    super.initState();
    _isHover = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: InkWell(
        onTap: () {
          widget.onTap.call();
        },
        onHover: (onHover) {
          setState(() {
            _isHover = !_isHover;
          });
        },
        child: Container(
          height: widget.heightOfOneItem,
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: _isHover
                ? theme.colorScheme.outline
                : theme.colorScheme.primaryContainer,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.text,
                style: theme.textTheme.bodyText1!.copyWith(
                    color: widget.isCurrentSelected
                        ? context.theme.colorScheme.onPrimaryContainer
                        : context.theme.colorScheme.onBackground),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
