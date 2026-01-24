// src/ui/table/data_extractor.dart
import 'package:flutter/material.dart';
import 'package:pilates_dashboard/app/reusable_widgets/extract_table_text_widget.dart';

/// A utility class for extracting text data from Flutter widgets.
///
/// This class provides methods to extract meaningful text content from various
/// widget types commonly used in table cells, such as Text, RichText, Row,
/// Column, and other container widgets.
class DataExtractor {
  /// Extracts text content from a widget.
  ///
  /// This method handles various widget types and extracts the text content
  /// in a way that's suitable for data export (e.g., to Excel).
  ///
  /// [widget] - The widget to extract text from
  /// Returns the extracted text as a string
  static String extractTextFromWidget(Widget widget) {
    // Check if widget implements ExtractableTextWidget
    if (widget is ExtractableTextWidget) {
      return (widget as ExtractableTextWidget).extractTableText;
    }

    // Direct text extraction
    if (widget is Text) {
      return widget.data ?? '';
    }

    if (widget is RichText) {
      return widget.text.toPlainText();
    }

    // Handle widgets with single child
    final singleChild = _getSingleChild(widget);
    if (singleChild != null) {
      return extractTextFromWidget(singleChild);
    }

    // Handle widgets with multiple children
    final multiChildren = _getMultipleChildren(widget);
    if (multiChildren.isNotEmpty) {
      final List<String> texts = [];
      for (final child in multiChildren) {
        final text = extractTextFromWidget(child);
        if (text.isNotEmpty) {
          texts.add(text);
        }
      }
      return texts.join(' ');
    }

    return '';
  }

  /// Gets the single child from widgets that have one child.
  static Widget? _getSingleChild(Widget widget) {
    if (widget is Container) return widget.child;
    if (widget is Padding) return widget.child;
    if (widget is Center) return widget.child;
    if (widget is SizedBox) return widget.child;
    if (widget is Expanded) return widget.child;
    if (widget is Flexible) return widget.child;
    if (widget is Align) return widget.child;
    if (widget is ClipRRect) return widget.child;
    if (widget is DecoratedBox) return widget.child;
    if (widget is Material) return widget.child;
    if (widget is InkWell) return widget.child;
    if (widget is GestureDetector) return widget.child;
    if (widget is Opacity) return widget.child;
    if (widget is Transform) return widget.child;
    if (widget is Positioned) return widget.child;
    if (widget is SafeArea) return widget.child;
    if (widget is Scaffold) return widget.body;
    if (widget is Card) return widget.child;
    if (widget is ListTile) return widget.title;
    if (widget is AppBar) return widget.title;
    if (widget is Drawer) return widget.child;
    if (widget is DrawerHeader) return widget.child;
    if (widget is SingleChildScrollView) return widget.child;

    return null;
  }

  /// Gets multiple children from widgets that have multiple children.
  static List<Widget> _getMultipleChildren(Widget widget) {
    final List<Widget> children = [];

    if (widget is Row) {
      children.addAll(widget.children);
    } else if (widget is Column) {
      children.addAll(widget.children);
    } else if (widget is Stack) {
      children.addAll(widget.children);
    } else if (widget is Wrap) {
      children.addAll(widget.children);
    } else if (widget is Flow) {
      children.addAll(widget.children);
    } else if (widget is CustomMultiChildLayout) {
      children.addAll(widget.children);
    } else if (widget is IndexedStack) {
      children.addAll(widget.children);
    } else if (widget is ListBody) {
      children.addAll(widget.children);
    } else if (widget is Flex) {
      children.addAll(widget.children);
    }

    return children;
  }
}
