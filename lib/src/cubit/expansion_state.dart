part of 'expansion_cubit.dart';

class ExpansionState extends Equatable {
  final bool isExpanded;
  ExpansionState({
    required this.isExpanded,
  }) {
    print(this.hashCode);
  }

  @override
  List<Object> get props => [isExpanded];
}
