import 'package:flutter/material.dart';

/// A reusable responsive table component that switches between
/// a horizontal-scrollable DataTable on wide screens and
/// a Card/List view on narrow screens.
class ResponsiveTable<T> extends StatelessWidget {
  /// Breakpoint (in logical pixels) below which the table switches to a list view.
  final double narrowBreakpoint;

  /// Column definitions for DataTable.
  final List<DataColumn> columns;

  /// The raw data items.
  final List<T> data;

  /// Builds a DataRow for each item when in table mode.
  final DataRow Function(T item) rowBuilder;

  /// Optional: builds a Widget (e.g. Card or ListTile) for each item when in list mode.
  /// If not provided, a simple ListTile is generated showing the first two columns.
  final Widget Function(T item)? itemBuilder;

  const ResponsiveTable({
    Key? key,
    required this.columns,
    required this.data,
    required this.rowBuilder,
    this.itemBuilder,
    this.narrowBreakpoint = 600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < narrowBreakpoint;
        if (isNarrow) {
          // List/Card view
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              if (itemBuilder != null) {
                return itemBuilder!(item);
              }
              // default fallback: show first two cells
              final row = rowBuilder(item);
              final cells = row.cells;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: cells.isNotEmpty ? cells[0].child : const SizedBox(),
                  subtitle: cells.length > 1 ? cells[1].child : null,
                  trailing: cells.length > 2 ? cells[2].child : null,
                ),
              );
            },
          );
        } else {
          // Table view with horizontal scroll
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns,
              rows: data.map(rowBuilder).toList(),
            ),
          );
        }
      },
    );
  }
}

// Example usage:
//
// ResponsiveTable<MyItem>(
//   narrowBreakpoint: 640,
//   columns: const [
//     DataColumn(label: Text('Name')),
//     DataColumn(label: Text('Age')),
//     DataColumn(label: Text('Role')),
//   ],
//   data: myItems,
//   rowBuilder: (item) => DataRow(cells: [
//     DataCell(Text(item.name)),
//     DataCell(Text(item.age.toString())),
//     DataCell(Text(item.role)),
//   ]),
//   itemBuilder: (item) => Card(
//     margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//     child: ListTile(
//       title: Text(item.name),
//       subtitle: Text('Age: ${item.age}'),
//       trailing: Text(item.role),
//     ),
//   ),
// );
