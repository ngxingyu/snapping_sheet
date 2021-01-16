import 'package:flutter/animation.dart';

enum SnappingPositionContent {
  sheetAbove,
  sheetBelow,
  none,
}

class SnappingPosition {
  final double? _positionPixel;
  final double? _positionFactor;
  final SnappingPositionContent positionDependsOnContent;
  final double alignmentRelativeToGrabbingContent;

  /// The animation curve to this snapping position
  final Curve snappingCurve;

  /// The snapping duration
  final Duration snappingDuration;

  /// Creates a snapping position that is given by the amount of pixels
  const SnappingPosition.pixels({
    required double positionPixels,
    this.snappingCurve = Curves.ease,
    this.snappingDuration = const Duration(milliseconds: 250),
    this.alignmentRelativeToGrabbingContent = 0,
  })  : this._positionPixel = positionPixels,
        this.positionDependsOnContent = SnappingPositionContent.none,
        this._positionFactor = null;

  /// Creates a snapping position that is given a positionFactor
  /// [positionFactor]: 1 = Max size; 0 = Min size.
  const SnappingPosition.factor({
    required double positionFactor,
    this.snappingCurve = Curves.easeOutSine,
    this.snappingDuration = const Duration(milliseconds: 250),
    this.alignmentRelativeToGrabbingContent = 0,
  })  : this._positionPixel = null,
        this.positionDependsOnContent = SnappingPositionContent.none,
        this._positionFactor = positionFactor;

  /// Creates a snapping position that is given a positionFactor
  /// [positionFactor]: 1 = Max size; 0 = Min size.
  const SnappingPosition.content({
    required SnappingPositionContent positionDependsOnContent,
    this.snappingCurve = Curves.ease,
    this.snappingDuration = const Duration(milliseconds: 250),
    this.alignmentRelativeToGrabbingContent = 0,
  })  : this._positionPixel = null,
        this.positionDependsOnContent = positionDependsOnContent,
        this._positionFactor = null;

  /// Getting the position in pixels
  double positionInPixels(
    double snappingSheetHeight,
    double aboveSheetHeight,
    double belowSheetHeight,
    double grabbingContentHeight,
  ) {
    var positionPixel = _positionInPixelsCenter(
      snappingSheetHeight,
      aboveSheetHeight,
      belowSheetHeight,
    );
    var grabbingContentOffset =
        grabbingContentHeight / 2 * alignmentRelativeToGrabbingContent -
            grabbingContentHeight / 2;
    return positionPixel + grabbingContentOffset;
  }

  double _positionInPixelsCenter(
    double snappingSheetHeight,
    double aboveSheetHeight,
    double belowSheetHeight,
  ) {
    var positionPixel = _positionPixel;
    if (positionPixel != null) return positionPixel;

    var positionFactor = _positionFactor;
    if (positionFactor != null) return positionFactor * snappingSheetHeight;

    if (positionDependsOnContent == SnappingPositionContent.sheetAbove)
      return aboveSheetHeight;

    if (positionDependsOnContent == SnappingPositionContent.sheetBelow)
      return snappingSheetHeight - belowSheetHeight;

    return 0;
  }
}
