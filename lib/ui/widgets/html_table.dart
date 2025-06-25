import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

/// A simple HTML-like table widget with borders, flexible columns, optional rounded corners, and configurable cell sizes.
/// It scrolls horizontally when the content overflows the available width.
class HtmlTable extends StatelessWidget {
  final List<Widget> headers;
  final List<List<Widget>> rows;
  final BorderRadiusGeometry? borderRadius;
  final List<TableColumnWidth>? columnWidths;

  /// Color and width for the outer border
  final Color outerBorderColor;
  final double outerBorderWidth;

  /// Color and width for inside borders
  final Color innerBorderColor;
  final double innerBorderWidth;

  /// Fixed height for each table row (including header)
  final double? rowHeight;

  /// Padding inside each cell
  final EdgeInsetsGeometry cellPadding;

  /// Optional fixed width for every cell
  final double? cellWidth;

  final int? maxVisibleRows;

  const HtmlTable({
    super.key,
    required this.headers,
    required this.rows,
    this.borderRadius,
    this.columnWidths,
    this.outerBorderColor = Colors.grey,
    this.outerBorderWidth = 1.0,
    this.innerBorderColor = Colors.grey,
    this.innerBorderWidth = 1.0,
    this.rowHeight,
    this.cellPadding = const EdgeInsets.all(8.0),
    this.cellWidth,
    this.maxVisibleRows,
  }) : assert(columnWidths == null || columnWidths.length == headers.length);

  @override
  Widget build(BuildContext context) {
    Widget content = Table(
      columnWidths: columnWidths != null
          ? Map<int, TableColumnWidth>.fromIterables(
              List.generate(columnWidths!.length, (i) => i),
              columnWidths!,
            )
          : const {},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      // border: TableBorder(
      //   horizontalInside: BorderSide(
      //     width: innerBorderWidth,
      //     color: innerBorderColor,
      //   ),
      //   verticalInside: BorderSide(
      //     width: innerBorderWidth,
      //     color: innerBorderColor,
      //   ),
      // ),
      children: [
        // Header row
        TableRow(
          decoration: BoxDecoration(color: AppColors.surface),
          children: headers.map((cell) {
            Widget contentCell = DefaultTextStyle(
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundSurface,
              ),
              child: cell,
            );
            if (rowHeight != null) {
              contentCell = Container(
                height: rowHeight,
                alignment: Alignment.center,
                child: contentCell,
              );
            }
            if (cellWidth != null) {
              contentCell = Container(
                width: cellWidth,
                alignment: Alignment.center,
                child: contentCell,
              );
            }
            return Column(
              children: [
                Container(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                  child: contentCell,
                ),
                Container(height: innerBorderWidth, color: innerBorderColor),
              ],
            );
          }).toList(),
        ),
        // for (final row in rows)
        for (final row
            in (maxVisibleRows != null ? rows.take(maxVisibleRows!) : rows))
          TableRow(
            children: row.map((cell) {
              Widget contentCell = cell;
              if (rowHeight != null) {
                contentCell = Container(
                  height: rowHeight,
                  alignment: Alignment.center,
                  child: contentCell,
                );
              }
              if (cellWidth != null) {
                contentCell = Container(
                  width: cellWidth,
                  alignment: Alignment.center,
                  child: contentCell,
                );
              }
              return Padding(padding: cellPadding, child: contentCell);
            }).toList(),
          ),
      ],
    );

    Widget tableContainer = Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: borderRadius,
        border: Border.all(color: outerBorderColor, width: outerBorderWidth),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: content,
      ),
    );

    // Wrap in SizedBox if rowHeight is specified to fix vertical height
    // if (rowHeight != null) {
    //   final totalHeight =
    //       (rowHeight! + cellPadding.vertical) * (rows.length + 1);
    //   tableContainer = SizedBox(height: totalHeight, child: tableContainer);
    // }

    return Material(
      elevation: 1,
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Align(alignment: Alignment.topLeft, child: tableContainer),
        ),
      ),
    );
  }
}

// Example usage:
// HtmlTable(
//   headers: [Text('Name'), Text('Age'), Text('Role')],
//   rows: [
//     [Text('Alice'), Text('28'), Text('Admin')],
//     [Text('Bob'), Text('34'), Text('Director')],
//   ],
//   columnWidths: [IntrinsicColumnWidth(), FixedColumnWidth(80), IntrinsicColumnWidth(flex:2)],
//   borderRadius: BorderRadius.circular(12),
//   outerBorderColor: Colors.blue,
//   innerBorderColor: Colors.grey.shade300,
//   rowHeight: 60,
//   cellWidth: 100, // fixed width per cell
//   cellPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// );
