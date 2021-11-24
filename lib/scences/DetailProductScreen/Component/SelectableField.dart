import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SelectableField extends StatelessWidget {
  SelectableField(this._values, this._selectedIndex, this._output);

  BehaviorSubject<int> _output;
  BehaviorSubject<int> _selectedIndex;
  List<String> _values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        runSpacing: 12,
        alignment: WrapAlignment.start,
        children: _buildListButtons(context),
      ),
    );
  }
}

extension _SelectableField on SelectableField {
  Widget _buildButton(BuildContext context, String value, int index) {
    return StreamBuilder<int>(
      stream: _selectedIndex,
      builder: (context, snapshot) {
        final isSelected = snapshot.data == index;
        final color = kPrimaryColor;
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: FONT_REGULAR,
                  color: isSelected ? Colors.white : primaryColor),
            ),
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.transparent,
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          onTap: () {
            _selectedIndex.add(index);
            _output.add(index);
          },
        );
      },
    );
  }

  List<Widget> _buildListButtons(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < _values.length; i++) {
      widgets.add(_buildButton(context, _values[i], i));
    }
    return widgets;
  }
}
