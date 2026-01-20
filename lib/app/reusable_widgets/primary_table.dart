import 'package:flutter/material.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/reusable_widgets/data_extractor.dart';

class PrimaryTableColumn<T> {
  final String title;
  final Widget Function(T item) cellBuilder;
  final int flex;
  final Function(bool ascending)? onSort;
  final TextAlign? textAlign;

  PrimaryTableColumn({
    required this.title,
    required this.cellBuilder,
    this.flex = 1,
    this.onSort,
    this.textAlign,
  });
}

class PrimaryTable<T> extends StatelessWidget {
  final List<PrimaryTableColumn<T>> columns;
  final List<T> items;
  final Function(T item)? onRowTap;
  final Widget? emptyWidget;
  final double rowHeight;
  final EdgeInsets cellPadding;
  final bool showBorder;
  final bool isSelectable;
  final List<T>? selectedItems;
  final Function(List<T> selectedItems)? onSelectionChanged;
  final bool checkboxOnRight;
  final int? maxItems;
  final bool isDataExportAllowed;
  final List<int>? exportColumns;
  final Function(Map<String, dynamic> exportData)? onExportData;

  const PrimaryTable({
    super.key,
    required this.columns,
    required this.items,
    this.onRowTap,
    this.emptyWidget,
    this.rowHeight = 60,
    this.cellPadding = const EdgeInsets.all(16.0),
    this.showBorder = true,
    this.isSelectable = false,
    this.selectedItems,
    this.onSelectionChanged,
    this.checkboxOnRight = false,
    this.maxItems = 6,
    this.isDataExportAllowed = false,
    this.exportColumns,
    this.onExportData,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return emptyWidget ?? const SizedBox.shrink();
    }

    final bool isScrollable = items.length >= 6;

    final double tableHeight = isScrollable
        ? rowHeight * (maxItems ?? 6)
        : rowHeight * items.length;

    return Container(
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: Colors.grey.shade200) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                if (isSelectable && !checkboxOnRight)
                  _buildHeaderCheckbox(context),
                ...columns.map((column) => _buildHeaderCell(context, column)),
                if (isSelectable && checkboxOnRight)
                  _buildHeaderCheckbox(context),
                if (isDataExportAllowed) _buildExportButton(context),
              ],
            ),
          ),

          // Table Rows
          if (isScrollable)
            SizedBox(
              height: tableHeight,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items
                      .map((item) => _buildRow(context, item))
                      .toList(),
                ),
              ),
            )
          else
            Column(
              mainAxisSize: MainAxisSize.min,
              children: items.map((item) => _buildRow(context, item)).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildExportButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Color(0xFF222222), size: 20),
      onSelected: (value) {
        if (value == 'excel') {
          _exportToExcel(context);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'excel',
          child: Row(
            children: [
              const Icon(Icons.table_chart, size: 16, color: Color(0xFF222222)),
              const SizedBox(width: 8),
              Text(
                "Export to Excel",
                style: TextStyle(fontSize: 12, color: const Color(0xFF222222)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _exportToExcel(BuildContext context) {
    if (onExportData == null) return;

    final List<int> columnsToExport =
        exportColumns ?? List.generate(columns.length, (index) => index);

    final List<String> headers = columnsToExport
        .map((index) => columns[index].title)
        .toList();

    final List<List<String>> data = items.map((item) {
      return columnsToExport.map((columnIndex) {
        final column = columns[columnIndex];
        final widget = column.cellBuilder(item);

        return DataExtractor.extractTextFromWidget(widget);
      }).toList();
    }).toList();

    // Prepare export data
    final Map<String, dynamic> exportData = {'headers': headers, 'data': data};

    // Call the export callback
    onExportData!(exportData);
  }

  Widget _buildHeaderCheckbox(BuildContext context) {
    final bool allSelected = selectedItems?.length == items.length;
    final bool hasSelection = selectedItems?.isNotEmpty ?? false;

    return Padding(
      padding: cellPadding,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Checkbox(
          value: allSelected,
          tristate: hasSelection && !allSelected,
          side: BorderSide(width: 1.0, color: AppColors.primaryColor),
          activeColor: AppColors.primaryColor,
          onChanged: (bool? value) {
            if (onSelectionChanged != null) {
              if (value ?? false) {
                onSelectionChanged!(List.from(items));
              } else {
                onSelectionChanged!([]);
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCell(BuildContext context, PrimaryTableColumn<T> column) {
    return Expanded(
      flex: column.flex,
      child: Padding(
        padding: cellPadding,
        child: Row(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => Text(
                  column.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF222222),
                  ),
                  textAlign: column.textAlign,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (column.onSort != null) ...[
              IconButton(
                onPressed: () => column.onSort!(true),
                icon: const Icon(
                  Icons.arrow_upward,
                  size: 16,
                  color: Color(0xFF222222),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, T item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onRowTap != null) {
            onRowTap!(item);
          }
        },
        mouseCursor: SystemMouseCursors.click,
        hoverColor: Colors.grey.shade100,
        child: Container(
          height: rowHeight,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isSelectable && !checkboxOnRight)
                _buildRowCheckbox(context, item),
              ...columns.map((column) => _buildCell(column, item)),
              if (isSelectable && checkboxOnRight)
                _buildRowCheckbox(context, item),
              if (isDataExportAllowed) _buildExportPlaceholder(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowCheckbox(BuildContext context, T item) {
    final bool isSelected = selectedItems?.contains(item) ?? false;

    return Padding(
      padding: cellPadding,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Checkbox(
          value: isSelected,
          side: BorderSide(width: 1.0, color: AppColors.primaryColor),
          activeColor: AppColors.primaryColor,
          onChanged: (bool? value) {
            if (onSelectionChanged != null) {
              final newSelection = List<T>.from(selectedItems ?? []);
              if (value ?? false) {
                if (!newSelection.contains(item)) {
                  newSelection.add(item);
                }
              } else {
                newSelection.remove(item);
              }
              onSelectionChanged!(newSelection);
            }
          },
        ),
      ),
    );
  }

  Widget _buildCell(PrimaryTableColumn<T> column, T item) {
    return Expanded(
      flex: column.flex,
      child: Padding(padding: cellPadding, child: column.cellBuilder(item)),
    );
  }

  Widget _buildExportPlaceholder(BuildContext context) {
    return const SizedBox(width: 48, child: SizedBox.shrink());
  }
}
