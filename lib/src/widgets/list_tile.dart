import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/expansion_cubit.dart';
import 'arrow_widget.dart';
import 'json_config.dart';
import 'json_view.dart';
import 'simple_tiles.dart';

class IndexRange {
  final int start;
  final int end;
  IndexRange({
    required this.start,
    required this.end,
  });

  int get length => end - start;
}

class ListTile extends StatefulWidget {
  final String keyName;
  final List items;
  final IndexRange range;
  final bool expanded;
  final Widget? arrow;
  const ListTile({
    Key? key,
    required this.keyName,
    required this.items,
    required this.range,
    this.expanded = false,
    this.arrow,
  }) : super(key: key);

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpansionCubit(widget.expanded),
      child: _ListTile(
        keyName: widget.keyName,
        items: widget.items,
        arrow: widget.arrow,
        range: widget.range,
        isExpanded: widget.expanded,
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String keyName;
  final List items;
  final IndexRange range;
  final Widget? arrow;
  final bool isExpanded;

  const _ListTile({
    Key? key,
    required this.keyName,
    required this.items,
    required this.range,
    required this.arrow,
    required this.isExpanded,
  }) : super(key: key);

  // String get _value {
  //   if (items.isEmpty) return '[]';
  //   if (_expanded) return '';
  //   if (widget.items.length == 1) return '[0]';
  //   if (widget.items.length == 2) return '[0,1]';
  //   return '[${widget.range.start} ... ${widget.range.end}]';
  // }

  void _changeState(BuildContext context) {
    if (items.isNotEmpty) context.read<ExpansionCubit>().toogleExpansion();
  }

  List<Widget> get _children {
    if (items.isEmpty) return [];

    //GAP 100
    if (range.length < 100) {
      final result = <Widget>[];
      for (var i = 0; i <= range.length; i++) {
        result.add(getIndexedItem(i, items[i], false, arrow));
      }
      return result;
    }
    return _gapChildren;
  }

  List<Widget> get _gapChildren {
    int gap = 100;
    while (range.length / gap > 100) {
      gap *= 100;
    }
    int divide = range.length ~/ gap;
    int dividedLength = gap * divide;
    late int gapSize;
    if (dividedLength == items.length) {
      gapSize = divide;
    } else {
      gapSize = divide + 1;
    }
    final _result = <Widget>[];
    for (var i = 0; i < gapSize; i++) {
      int startIndex = range.start + i * gap;
      int endIndex = range.end;
      if (i != gapSize - 1) {
        _result.add(
          ListTile(
            keyName: '[$i]',
            items: items,
            range: IndexRange(start: startIndex, end: startIndex + gap - 1),
            arrow: arrow,
            expanded: isExpanded,
          ),
        );
      } else {
        _result.add(
          ListTile(
            keyName: '[$i]',
            items: items,
            range: IndexRange(start: startIndex, end: endIndex),
            arrow: arrow,
            expanded: isExpanded,
          ),
        );
      }
    }
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    final jsonConfig = JsonConfig.of(context);
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: jsonConfig.customArrowAnimationDuration ??
          const Duration(milliseconds: 300),
      curve: jsonConfig.customArrowAnimationCurve ?? Curves.ease,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ExpansionCubit, ExpansionState>(
            builder: (context, state) => KeyValueTile(
              keyName: keyName,
              value: () {
                if (items.isEmpty) return '[]';
                if (state.isExpanded) return '';
                if (items.length == 1) return '[0]';
                if (items.length == 2) return '[0,1]';
                return '[${range.start} ... ${range.end}]';
              }(),
              onTap: () => _changeState(context),
              leading: items.isEmpty ? null : _arrowWidget,
              valueWidget: state.isExpanded
                  ? Padding(
                      padding: jsonConfig.itemPadding!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _children,
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _arrowWidget => BlocBuilder<ExpansionCubit, ExpansionState>(
        builder: (context, state) => arrow == null
            ? ArrowWidget(
                direction: state.isExpanded
                    ? ArrowDirection.down
                    : ArrowDirection.right,
                onTap: () => _changeState(context),
              )
            : MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _changeState(context),
                  child: AnimatedRotation(
                    turns: state.isExpanded ? 0 : -.25,
                    duration:
                        JsonConfig.of(context).customArrowAnimationDuration ??
                            const Duration(milliseconds: 300),
                    curve: JsonConfig.of(context).customArrowAnimationCurve ??
                        Curves.ease,
                    child: arrow,
                  ),
                ),
              ),
      );
}
