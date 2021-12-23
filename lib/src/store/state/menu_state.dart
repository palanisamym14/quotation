import 'package:flutter/material.dart';

@immutable
class MenuState {
  final bool isVisible;

  MenuState({
    required this.isVisible,
  });

  factory MenuState.initial() {
    return new MenuState(
      isVisible: true,
    );
  }
  MenuState copyWith({
    required bool isVisible,
  }) {
    return new MenuState(isVisible: isVisible);
  }
}
