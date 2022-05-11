import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../json_view.dart';
import '../cubit/expansion_cubit.dart';
import 'arrow_widget.dart';
import 'simple_tiles.dart';

class MapTile extends StatefulWidget {
  final String keyName;
  final List<MapEntry> items;
  final bool expanded;
  final Widget? arrow;
  const MapTile({
    Key? key,
    required this.keyName,
    required this.items,
    this.expanded = false,
    this.arrow,
  }) : super(key: key);

  @override
  State<MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<MapTile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpansionCubit>(
      create: (context) => ExpansionCubit(widget.expanded),
      child: _MapTile(
        keyName: widget.keyName,
        items: widget.items,
        arrow: widget.arrow,
      ),
    );
  }
}

class _MapTile extends StatelessWidget {
  final String keyName;
  final List<MapEntry> items;
  final Widget? arrow;
  const _MapTile({
    Key? key,
    required this.keyName,
    required this.items,
    required this.arrow,
  }) : super(key: key);

  void _changeState(BuildContext context) {
    if (items.isNotEmpty) {
      context.read<ExpansionCubit>().toogleExpansion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: JsonConfig.of(context).animationDuration ??
          const Duration(milliseconds: 300),
      curve: JsonConfig.of(context).animationCurve ?? Curves.ease,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ExpansionCubit, ExpansionState>(
            builder: (context, state) => KeyValueTile(
              keyName: keyName,
              value: () {
                if (items.isEmpty) return '{}';
                if (state.isExpanded) return '';
                return '{ ... }';
              }(),
              onTap: () => _changeState(context),
              leading: items.isEmpty ? null : _arrowWidget,
              valueWidget: state.isExpanded
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items.map((item) {
                          return getParsedItem(
                            item.key,
                            item.value,
                            false,
                            arrow,
                          );
                        }).toList(),
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
        builder: (context, state) => ArrowWidget(
          expanded: state.isExpanded,
          onTap: () => _changeState(context),
          customArrow: arrow,
        ),
      );
}
