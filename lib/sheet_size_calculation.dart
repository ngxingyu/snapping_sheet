import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet_content.dart';

abstract class SheetSizeCalculation {
  final BoxConstraints boxConstraints;
  final SnappingSheetContent sheetContent;

  SheetSizeCalculation(this.sheetContent, this.boxConstraints);

  double? getSheetStartPosition() {
    var sizeBehavior = sheetContent.snappingSheetSizeBehavior;
    var sheetHeight = sheetContent.height;

    if (sizeBehavior is SheetSizeFit) return 0;

    if (sizeBehavior is SheetSizeFixed) {
      var isOverflowing = getSheetEndPosition() < sheetHeight;
      if (sizeBehavior.expandOnOverflow && isOverflowing) return 0;
      return null;
    }

    return null;
  }

  double getSheetEndPosition();
}

class AboveSheetSizeCalculation extends SheetSizeCalculation {
  final double currentPosition;

  AboveSheetSizeCalculation({
    required this.currentPosition,
    required SnappingSheetContent sheetContent,
    required BoxConstraints boxConstraints,
  }) : super(
          sheetContent,
          boxConstraints,
        );

  @override
  double getSheetEndPosition() {
    return boxConstraints.maxHeight - currentPosition;
  }
}

class BelowSheetSizeCalculation extends SheetSizeCalculation {
  final double currentPosition;
  final double grabbingWidgetHeight;

  BelowSheetSizeCalculation({
    required this.currentPosition,
    required this.grabbingWidgetHeight,
    required SnappingSheetContent sheetContent,
    required BoxConstraints boxConstraints,
  }) : super(
          sheetContent,
          boxConstraints,
        );

  @override
  double getSheetEndPosition() {
    return currentPosition + this.grabbingWidgetHeight;
  }
}
