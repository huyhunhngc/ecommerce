import 'dart:async';
import 'dart:math';

import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class _Dropdown {
  _Dropdown({required this.box, required this.offset, required this.widget});

  RenderBox box;
  double offset;
  Widget widget;
}

class AppDropdownButton extends StatefulWidget {
  AppDropdownButton(
      {Key? key,
      required this.values,
      this.assetValues,
      required this.hint,
      required this.currentIndex,
      required this.controller,
      this.itemHeight = 36,
      this.offset = 10,
      this.listPadding = const EdgeInsets.only(top: 16, bottom: 16)})
      : super(key: key);

  List<String> values;
  List<String>? assetValues;
  String hint;
  BehaviorSubject<int?> currentIndex;
  double itemHeight;
  double offset;
  EdgeInsets listPadding;
  AppDropdownController controller;

  @override
  _AppDropdownButtonState createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  bool isExpanded = false;

  String? get value {
    if (widget.currentIndex.value != null) {
      return widget.values[widget.currentIndex.value!];
    }
    return null;
  }

  String? get assetValue {
    if (widget.currentIndex.value != null && widget.assetValues != null) {
      return widget.assetValues![widget.currentIndex.value!];
    }
    return null;
  }

  Color get currentColor {
    return value != null ? primaryColor : Color(0xFF7C7C7C);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: 56,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: currentColor.withAlpha(150)),
        ),
      ),
      child: buildButton(context),
    );
  }

  Widget buildButton(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Visibility(
              visible: widget.assetValues != null,
              child: Container(
                padding: EdgeInsets.only(right: 20),
                child: Image(
                  image: AssetImage(assetValue ?? LAUNCH_IMAGE),
                ),
              ),
            ),
            Text(
              value ?? widget.hint,
              style: TextStyle(color: currentColor),
            ),
            Spacer(),
            Transform.rotate(
              angle: isExpanded ? pi : 0,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: currentColor,
              ),
            )
          ],
        ),
      ),
      onPressed: () {
        if (isExpanded) {
          widget.controller.close();
        } else {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            isExpanded = true;
          });
          final RenderBox button = context.findRenderObject()! as RenderBox;
          widget.controller
              .display(
                  buildList(context, button.size.width), button, widget.offset)
              .then(
            (_) {
              setState(
                () {
                  isExpanded = false;
                },
              );
            },
          );
        }
      },
    );
  }

  Widget buildList(BuildContext context, double width) {
    return _DropdownList(
      values: widget.values,
      assetValues: widget.assetValues,
      width: width,
      itemHeight: widget.itemHeight,
      listPadding: widget.listPadding,
      selectedIndex: widget.currentIndex.value,
      onSelect: (index) {
        setState(() {
          widget.currentIndex.add(index);
        });
        widget.controller.close();
      },
    );
  }
}

class AppDropdownController {
  _Dropdown? _dropdown;
  Completer<void>? _currentDisplay;
  void Function(VoidCallback fn)? setState;

  Future<void> display(Widget widget, RenderBox box, double offset) {
    _completeCurrentDisplay();
    Completer<void> completer = Completer();
    _currentDisplay = completer;
    _updateDropdown(_Dropdown(widget: widget, box: box, offset: offset));
    return completer.future;
  }

  void close() {
    _updateDropdown(null);
    _completeCurrentDisplay();
  }
}

extension _AppDropdownController on AppDropdownController {
  void _updateDropdown(_Dropdown? dropdown) {
    if (setState != null) {
      setState!(() {
        _dropdown = dropdown;
      });
    }
  }

  void _completeCurrentDisplay() {
    if (_currentDisplay != null) {
      _currentDisplay!.complete();
      _currentDisplay = null;
    }
  }
}

class AppDropdownArea extends StatefulWidget {
  AppDropdownArea({Key? key, required this.body});

  Widget Function(AppDropdownController) body;

  @override
  _AppDropdownAreaState createState() => _AppDropdownAreaState();
}

class _AppDropdownAreaState extends State<AppDropdownArea> {
  _AppDropdownAreaState() {
    controller.setState = setState;
  }

  final controller = AppDropdownController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [widget.body(controller), buildList(context)],
    );
  }

  Widget buildList(BuildContext context) {
    if (controller._dropdown != null) {
      final button = controller._dropdown!.box;
      final buttonPosition = button.localToGlobal(Offset.zero);
      final globalPosition = Offset(
          buttonPosition.dx,
          buttonPosition.dy +
              button.size.height +
              controller._dropdown!.offset);
      final RenderBox renderBox = context.findRenderObject()! as RenderBox;
      final position = renderBox.globalToLocal(globalPosition);
      return Positioned(
          child: controller._dropdown!.widget,
          left: position.dx,
          top: position.dy);
    }
    return SizedBox(width: 0, height: 0);
  }
}

class _DropdownList extends StatefulWidget {
  _DropdownList(
      {required this.values,
      this.assetValues,
      required this.width,
      required this.itemHeight,
      required this.listPadding,
      required this.onSelect,
      this.selectedIndex});

  List<String> values;
  List<String>? assetValues;
  double width;
  double itemHeight;
  EdgeInsets listPadding;
  void Function(int) onSelect;
  int? selectedIndex;

  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<_DropdownList> {
  late final _scrollController = ScrollController(
      initialScrollOffset: widget.itemHeight * (widget.selectedIndex ?? 0));

  @override
  Widget build(BuildContext context) {
    final height = widget.itemHeight * min(4, widget.values.length) +
        widget.listPadding.top +
        widget.listPadding.bottom;
    final scrollOffset = widget.itemHeight * (widget.selectedIndex ?? 0);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(scrollOffset);
    }
    return Container(
      padding: widget.listPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      width: widget.width,
      height: height,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        itemCount: widget.values.length,
        itemBuilder: (_, index) {
          final isSelected = index == widget.selectedIndex;
          final color = Theme.of(context).primaryColor;
          return GestureDetector(
            onTap: () => widget.onSelect(index),
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 8),
              color: isSelected ? color.withAlpha(76) : Colors.transparent,
              width: widget.width,
              height: widget.itemHeight,
              child: Row(
                children: [
                  Visibility(
                    visible: widget.assetValues != null,
                    child: Container(
                      height: 20,
                      width: 50,
                      padding: EdgeInsets.only(right: 20),
                      child: Image(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(
                            widget.assetValues?[index] ?? LAUNCH_IMAGE),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                          color: isSelected ? color : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
