import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:snapping_sheet/widget_size.dart';

class SnappingContent {
  final bool isDraggable;
  final Widget _child;
  final GlobalKey _key = GlobalKey();
  double _currentHeight = 0;

  SnappingContent({
    required Widget child,
    this.isDraggable = false,
  }) : this._child = child;

  double get height {
    return _currentHeight;
  }

  Widget getChild({
    required VoidCallback onPointerUp,
    required VoidCallback onPointerDown,
    required Function(PointerMoveEvent dragEvent) onPointerMove,
  }) {
    return Listener(
      key: _key,
      behavior: HitTestBehavior.translucent,
      child: WidgetSize(
        onChange: (size) {
          _currentHeight = size.height;
        },
        child: this._child,
      ),
      onPointerUp: (_) {
        if (!isDraggable) return;
        onPointerUp();
      },
      onPointerDown: (_) {
        if (!isDraggable) return;
        onPointerDown();
      },
      onPointerMove: (pointerMoveEvent) {
        if (!isDraggable) return;
        onPointerMove(pointerMoveEvent);
      },
    );
  }
}
