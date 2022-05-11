import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expansion_state.dart';

class ExpansionCubit extends Cubit<ExpansionState> {
  ExpansionCubit(bool initialState)
      : super(ExpansionState(isExpanded: initialState));

  void toogleExpansion() => emit(ExpansionState(isExpanded: !state.isExpanded));
}
