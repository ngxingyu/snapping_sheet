import 'package:flutter/material.dart';
import 'package:snapping_sheet/sheet_size_calculation.dart';
import 'package:snapping_sheet/snapping_content.dart';
import 'package:snapping_sheet/snapping_handler.dart';
import 'package:snapping_sheet/snapping_positions.dart';
import 'package:snapping_sheet/snapping_sheet_content.dart';

class SnappingSheet extends StatefulWidget {
  /// The content that is located over the [grabbingContent]
  final SnappingSheetContent sheetAbove;

  /// The content that is often used to drag the sheets
  final SnappingContent grabbingContent;

  /// The content that is located under the [grabbingContent]
  final SnappingSheetContent sheetBelow;

  /// The content that is in under the [SnappingSheet] widget.
  final Widget childUnder;

  final List<SnappingPosition> snappingPositions;

  const SnappingSheet({
    Key? key,
    required this.sheetAbove,
    required this.grabbingContent,
    required this.sheetBelow,
    required this.childUnder,
    this.snappingPositions = const [
      SnappingPosition.factor(
        positionFactor: 1,
        alignmentRelativeToGrabbingContent: -1,
      ),
      SnappingPosition.content(
        positionDependsOnContent: SnappingPositionContent.sheetBelow,
        alignmentRelativeToGrabbingContent: -1,
      ),
    ],
  }) : super(key: key);

  @override
  _SnappingSheetState createState() => _SnappingSheetState();
}

class _SnappingSheetState extends State<SnappingSheet>
    with SingleTickerProviderStateMixin {
  double _currentPosition = 0;
  BoxConstraints _currentBoxConstraints = BoxConstraints();
  AnimationController? _animationController;
  Animation<double>? _animation;
  SnappingPosition? _lastSnappingPosition;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _animationController!.addListener(() {
      setState(() {
        _currentPosition = _animation!.value;
      });
    });

    Future.delayed(Duration(seconds: 0)).then((_) {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant SnappingSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration(seconds: 0)).then((_) {
      setState(() {});
    });
  }

  void _stopCurrentSnappingAnimation() {
    _animationController?.stop();
  }

  SnappingHandlerCalculator _getSnappingHandlerCalculator() {
    return SnappingHandlerCalculator(
        widget.snappingPositions,
        _currentPosition,
        _currentBoxConstraints,
        widget.sheetAbove.height,
        widget.sheetBelow.height,
        widget.grabbingContent.height);
  }

  void _snapToClosestSnappingPosition() {
    var calculator = _getSnappingHandlerCalculator();
    _snapToSnappingPosition(
      calculator.getClosestSnappingPosition(_lastSnappingPosition),
    );
  }

  void _snapToSnappingPosition(SnappingPosition snappingPosition) {
    var calculator = _getSnappingHandlerCalculator();

    var animationController = _animationController;
    if (animationController == null) return;

    _animation = Tween<double>(
            begin: _currentPosition,
            end: calculator.getSnappingPositionInPixels(snappingPosition))
        .animate(CurvedAnimation(
      curve: snappingPosition.snappingCurve,
      parent: animationController,
    ));

    animationController.duration = snappingPosition.snappingDuration;
    animationController.reset();
    animationController.forward();

    _lastSnappingPosition = snappingPosition;
  }

  void _handleDragEvent(PointerMoveEvent dragEvent) {
    var newPosition = _currentPosition + dragEvent.delta.dy;
    setState(() {
      _currentPosition = newPosition;
    });
  }

  Widget _getWidgetFromSnappingContent(SnappingContent content) {
    return Container(
      constraints: BoxConstraints(maxHeight: _currentBoxConstraints.maxHeight),
      child: content.getChild(
        onPointerDown: _stopCurrentSnappingAnimation,
        onPointerUp: _snapToClosestSnappingPosition,
        onPointerMove: _handleDragEvent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      _currentBoxConstraints = boxConstraints;
      var aboveSheetCalc = AboveSheetSizeCalculation(
          currentPosition: _currentPosition,
          sheetContent: widget.sheetAbove,
          boxConstraints: boxConstraints);
      var belowSheetCalc = BelowSheetSizeCalculation(
          grabbingWidgetHeight: widget.grabbingContent.height,
          currentPosition: _currentPosition,
          sheetContent: widget.sheetBelow,
          boxConstraints: boxConstraints);
      return Stack(
        fit: StackFit.expand,
        children: [
          widget.childUnder,
          Positioned(
            left: 0,
            right: 0,
            top: aboveSheetCalc.getSheetStartPosition(),
            bottom: aboveSheetCalc.getSheetEndPosition(),
            child: _getWidgetFromSnappingContent(widget.sheetAbove),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: _currentPosition,
            child: _getWidgetFromSnappingContent(widget.grabbingContent),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: belowSheetCalc.getSheetStartPosition(),
            top: belowSheetCalc.getSheetEndPosition(),
            child: _getWidgetFromSnappingContent(widget.sheetBelow),
          ),
        ],
      );
    });
  }
}
