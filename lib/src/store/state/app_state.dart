import 'package:meta/meta.dart';
import 'package:quotation/src/store/state/datagrid_state.dart';
import 'package:quotation/src/store/state/signin_state.dart';

enum LoadingStatus { loading, error, success }


@immutable
class AppState {
  final DataGridState dataGridState;
  final SignInState signInState;

  AppState({required this.dataGridState, required this.signInState});

  factory AppState.initial() {
    return AppState(
        dataGridState: DataGridState.initial(),
        signInState: SignInState.initial());
  }

  AppState copyWith({
    DataGridState? dataGridState,
    SignInState? signInState,
  }) {
    return AppState(
        dataGridState: dataGridState ?? this.dataGridState,
        signInState: signInState ?? this.signInState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          dataGridState == other.dataGridState &&
          signInState == other.signInState;

  @override
  int get hashCode => dataGridState.hashCode ^ signInState.hashCode;
}
