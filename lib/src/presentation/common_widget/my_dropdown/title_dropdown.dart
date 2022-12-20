import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';

import 'animated_appear.dart';
import 'dropdown_item.dart';

enum DropDownFrom {
  filter,
  detail,
}

class TitleDropdown<T> extends StatefulWidget {
  final Map<T, String> dropdownList;
  final String? label;
  final T? initialValue;
  final double width;
  final double heightOfOneItem;
  final TextStyle? style;
  final ValueChanged<dynamic> callBack;

  const TitleDropdown(
      {Key? key,
      required this.dropdownList,
      this.width = 150,
      this.style,
      required this.callBack,
      this.heightOfOneItem = 50,
      this.label,
      this.initialValue})
      : super(key: key);

  @override
  State<TitleDropdown> createState() => _TitleDropdownState();
}

class _TitleDropdownState extends State<TitleDropdown> {
  late String _currentSelected;
  late Set<String> _contentDropdown;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    if (widget.label == null && widget.initialValue != null) {
      _currentSelected = widget.dropdownList[widget.initialValue]!;
    } else {
      _currentSelected = widget.label!;
      // _contentDropdown.removeWhere((element) => element == _currentSelected);
    }
    _contentDropdown = Set.from(widget.dropdownList.values);

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CompositedTransformTarget(
      link: _layerLink,
      child: RawMaterialButton(
        onPressed: () {
          insertOverlay(context);
          if (mounted) {
            setState(() {});
          }
        },
        child: Container(
          color: context.theme.colorScheme.primaryContainer,
          padding: EdgeInsets.symmetric(
              vertical: _currentSelected != widget.label ? 8 : 14,
              horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (null != widget.label && _currentSelected != widget.label)
                Text(
                  widget.label!,
                  style:
                      context.theme.textTheme.bodyText1!.copyWith(fontSize: 11),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _currentSelected,
                    style: theme.textTheme.bodyText1,
                  ),
                  _overlayEntry == null
                      ? Icon(
                          Icons.arrow_drop_down,
                          color: theme.colorScheme.primary,
                        )
                      : Icon(
                          Icons.arrow_drop_up,
                          color: theme.colorScheme.primary,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertOverlay(
    BuildContext context,
  ) {
    closeDropDown();
    final rect = findParamsData(context);
    _overlayEntry = _createOverlay(rect: rect);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlay({required Rect rect}) {
    return OverlayEntry(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: GestureDetector(
                onTap: () {
                  closeDropDown();
                },
              ),
            ),
            Positioned.fromRect(
              rect: rect,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, widget.heightOfOneItem - 6),
                child: AnimatedAppear(
                  heightOfOneItem: widget.heightOfOneItem,
                  children: <Widget>[
                    for (int i = 0; i < _contentDropdown.length; i++)
                      DropDownItem(
                        width: rect.width,
                        heightOfOneItem: widget.heightOfOneItem,
                        isCurrentSelected:
                            _currentSelected == _contentDropdown.elementAt(i),
                        onTap: () {
                          _currentSelected = _contentDropdown.elementAt(i);

                          final entry = widget.dropdownList.entries.firstWhere(
                              (element) => element.value == _currentSelected);

                          widget.callBack(entry.key);

                          closeDropDown();
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        text: _contentDropdown.elementAt(i),
                        isFirstItem: _contentDropdown.first ==
                            _contentDropdown.elementAt(i),
                        isLastItem: _contentDropdown.last ==
                            _contentDropdown.elementAt(i),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Rect findParamsData(
    BuildContext context,
  ) {
    final RenderBox renderBox = context.findRenderObject()! as RenderBox;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return Rect.fromLTWH(offset.dx, offset.dy + size.height, size.width,
        widget.heightOfOneItem * _contentDropdown.length);
  }

  void closeDropDown() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    if (mounted) {
      setState(() {});
    }
  }
}
