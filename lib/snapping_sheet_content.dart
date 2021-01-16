import 'package:flutter/widgets.dart';
import 'package:snapping_sheet/snapping_content.dart';

class SnappingSheetContent extends SnappingContent {
  SheetSizeBehavior snappingSheetSizeBehavior;

  SnappingSheetContent({
    this.snappingSheetSizeBehavior = const SheetSizeFit(),
    bool isDraggable = false,
    required Widget child,
  }) : super(
          child: child,
          isDraggable: isDraggable,
        );
}

abstract class SheetSizeBehavior {
  const SheetSizeBehavior();
}

/// The content of the sheet is the same size as what is available
class SheetSizeFit implements SheetSizeBehavior {
  const SheetSizeFit();
}

/// The content of the sheet is fixed and do not change when the sheet
/// is dragged. Set [expandOnOverflow] to true to make the content expand
/// when the sheet is size bigger then the content
class SheetSizeFixed implements SheetSizeBehavior {
  final bool expandOnOverflow;
  const SheetSizeFixed({this.expandOnOverflow = false});
}
