part of 'expansion_cubit.dart';

class ExpansionState extends Equatable {
  final bool isExpanded;
  const ExpansionState({
    required this.isExpanded,
  });

  @override
  List<Object> get props => [isExpanded];
}
