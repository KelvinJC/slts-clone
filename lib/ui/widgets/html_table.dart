import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/themes/app_colors.dart';

class HtmlTable<T> extends StatelessWidget {
  final List<Widget> headers;
  final List<T> rowData;
  final List<List<Widget>> Function(List<T> rows) rowBuilder;
  final void Function(T row, int index)? onRowTap;

  // styling props (copy your existing ones here)…
  final BorderRadiusGeometry? borderRadius;
  final List<TableColumnWidth>? columnWidths;
  final Color outerBorderColor;
  final double outerBorderWidth;
  final Color innerBorderColor;
  final double innerBorderWidth;
  final double? rowHeight;
  final EdgeInsetsGeometry cellPadding;
  final double? cellWidth;
  final int? maxVisibleRows;

  const HtmlTable({
    Key? key,
    required this.headers,
    required this.rowData,
    required this.rowBuilder,
    this.onRowTap,
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
  }) : assert(columnWidths == null || columnWidths.length == headers.length),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build the Widgets for each T
    final builtRows = rowBuilder(rowData);
    final visibleRows = maxVisibleRows != null
        ? builtRows.take(maxVisibleRows!).toList()
        : builtRows;

    return Material(
      elevation: 1,
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: outerBorderColor,
                width: outerBorderWidth,
              ),
            ),
            child: ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.zero,
              child: Table(
                columnWidths: columnWidths != null
                    ? Map<int, TableColumnWidth>.fromIterables(
                        List.generate(columnWidths!.length, (i) => i),
                        columnWidths!,
                      )
                    : const {},
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  // Header row
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.surface),
                    children: headers.map((cell) {
                      Widget c = DefaultTextStyle(
                        style: const TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: AppColors.onBackgroundSurface,
                        ),
                        child: cell,
                      );
                      // Widget c = cell;
                      if (rowHeight != null) {
                        c = Container(
                          height: rowHeight,
                          alignment: Alignment.centerLeft,
                          child: c,
                        );
                      }
                      if (cellWidth != null) {
                        c = Container(
                          width: cellWidth,
                          alignment: Alignment.centerLeft,
                          child: c,
                        );
                      }
                      return Column(
                        children: [
                          Padding(padding: cellPadding, child: c),
                          Container(
                            height: innerBorderWidth,
                            color: innerBorderColor,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  // Data rows
                  for (var i = 0; i < visibleRows.length; i++)
                    TableRow(
                      children: visibleRows[i].map((cell) {
                        Widget c = cell;
                        if (rowHeight != null) {
                          c = Container(
                            height: rowHeight,
                            alignment: Alignment.centerLeft,
                            child: c,
                          );
                        }
                        if (cellWidth != null) {
                          c = Container(
                            width: cellWidth,
                            alignment: Alignment.centerLeft,
                            child: c,
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            if (onRowTap != null) {
                              onRowTap!(rowData[i], i);
                            }
                          },
                          child: Padding(padding: cellPadding, child: c),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
