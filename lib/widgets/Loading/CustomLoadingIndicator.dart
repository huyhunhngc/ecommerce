import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  static int _numberOfTask = 0;
  static OverlayEntry? _currentLoader;
  static void show(BuildContext context) {
    if (_numberOfTask == 0) {
      _currentLoader = OverlayEntry(
        builder: (context) => Stack(
          children: <Widget>[
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Center(
              child: LoadingIndicator(),
            ),
          ],
        ),
      );
      Overlay.of(context)?.insert(_currentLoader!);
    }
    _numberOfTask++;
  }

  static void hide() {
    if (_currentLoader != null) {
      _numberOfTask--;
      if (_numberOfTask == 0) {
        _currentLoader?.remove();
        _currentLoader = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
