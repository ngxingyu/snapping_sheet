import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_positions.dart';

enum _DragDirection {
  up,
  down,
  unknown,
}

class SnappingHandlerCalculator {
  final List<SnappingPosition> _snappingPositions;
  final double _currentPosition;
  final BoxConstraints _boxConstraints;
  final double _aboveSheetHeight;
  final double _belowSheetHeight;
  final double _grabbingContentHeight;

  SnappingHandlerCalculator(
    this._snappingPositions,
    this._currentPosition,
    this._boxConstraints,
    this._aboveSheetHeight,
    this._belowSheetHeight,
    this._grabbingContentHeight,
  );

  _DragDirection _getDragDirection(SnappingPosition? lastSnappingPosition) {
    if (lastSnappingPosition == null) return _DragDirection.unknown;

    var lastSnappingPositionPixels =
        getSnappingPositionInPixels(lastSnappingPosition);

    if (lastSnappingPositionPixels > _currentPosition)
      return _DragDirection.up;
    else
      return _DragDirection.down;
  }

  SnappingPosition getClosestSnappingPosition(
      SnappingPosition? lastSnappingPosition) {
    SnappingPosition closestSnappingSheet = this._snappingPositions.first;
    var minDistance = double.infinity;
    for (var snappingPosition in this._snappingPositions) {
      var newDistance = getDistanceFromSnappingPosition(snappingPosition);
      var dragDirection = _getDragDirection(lastSnappingPosition);
      bool snappingPositionAbove = newDistance < 0;
      bool snappingPositionBelow = !snappingPositionAbove;

      bool skipSnappingPosition = snappingPosition != lastSnappingPosition &&
          ((snappingPositionBelow && dragDirection == _DragDirection.up) ||
              (snappingPositionAbove && dragDirection == _DragDirection.down));

      if (skipSnappingPosition) continue;

      var sensitiveFactor = snappingPosition == lastSnappingPosition ? 5 : 1;
      var distanceToCompare = newDistance.abs() * sensitiveFactor;

      if (distanceToCompare < minDistance) {
        closestSnappingSheet = snappingPosition;
        minDistance = distanceToCompare;
      }
    }
    return closestSnappingSheet;
  }

  double getDistanceFromSnappingPosition(SnappingPosition snappingPosition) {
    var snappingPositionPixel = getSnappingPositionInPixels(snappingPosition);
    return snappingPositionPixel - _currentPosition;
  }

  double getSnappingPositionInPixels(SnappingPosition snappingPosition) {
    return snappingPosition.positionInPixels(
      _boxConstraints.maxHeight,
      _aboveSheetHeight,
      _belowSheetHeight,
      _grabbingContentHeight,
    );
  }
}
