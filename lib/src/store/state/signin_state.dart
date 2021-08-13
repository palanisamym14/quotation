
import 'package:flutter/material.dart';

@immutable
class SignInState {
  final List<Map<String, dynamic>> rowData;

  SignInState({
    required this.rowData,
  });

  factory SignInState.initial() {
    return new SignInState(
      rowData: [],
    );
  }
  SignInState copyWith({
    List<Map<String, dynamic>>? rowData,
  }) {
    return new SignInState(rowData: rowData ?? this.rowData);
  }
}