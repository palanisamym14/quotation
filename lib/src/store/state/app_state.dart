import 'package:meta/meta.dart';
import 'package:quotation/src/store/state/datagrid_state.dart';
import 'package:quotation/src/store/state/menu_state.dart';

enum LoadingStatus { loading, error, success }

@immutable
class AppState {
  final DataGridState dataGridState;
  final MenuState menuState;

  AppState({required this.dataGridState, required this.menuState});

  factory AppState.initial() {
    return AppState(
        dataGridState: DataGridState.initial(), menuState: MenuState.initial());
  }

  AppState copyWith({
    DataGridState? dataGridState,
    MenuState? menuState,
  }) {
    return AppState(
        dataGridState: dataGridState ?? this.dataGridState,
        menuState: menuState ?? this.menuState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          dataGridState == other.dataGridState &&
          menuState == other.menuState;

  @override
  int get hashCode => dataGridState.hashCode ^ menuState.hashCode;
}
