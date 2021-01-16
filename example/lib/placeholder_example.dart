import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:snapping_sheet/snapping_content.dart';
import 'package:snapping_sheet/snapping_sheet_content.dart';

class PlaceholderSnapSheetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placeholder example'),
      ),
      body: SnappingSheet(
        sheetAbove: SnappingSheetContent(
          snappingSheetSizeBehavior: SheetSizeFit(),
          child: Placeholder(color: Colors.red),
        ),
        grabbingContent: SnappingContent(
          isDraggable: true,
          child: SizedBox(
            height: 100,
            child: Placeholder(color: Colors.blue),
          ),
        ),
        sheetBelow: SnappingSheetContent(
          isDraggable: true,
          snappingSheetSizeBehavior: SheetSizeFixed(
            expandOnOverflow: false,
          ),
          child: Container(
            color: Colors.blue,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Hello"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        childUnder: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
