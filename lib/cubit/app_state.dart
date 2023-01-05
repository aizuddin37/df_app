import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final bool isInitialize;

  AppState({required this.isLoading, required this.isInitialize});

  copyWith({bool? isLoading, bool? isInitialize});
}
