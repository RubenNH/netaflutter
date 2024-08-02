import 'package:equatable/equatable.dart';
import '../../data/models/patin_electrico_model.dart';

class PatinElectricoState extends Equatable {
  const PatinElectricoState();

  @override
  List<Object> get props => [];
}

class PatinElectricoInitial extends PatinElectricoState {}

class PatinElectricoLoading extends PatinElectricoState {}

class PatinElectricoLoaded extends PatinElectricoState {
  final List<PatinElectricoModel> patinElectricos;

  const PatinElectricoLoaded({required this.patinElectricos});

  @override
  List<Object> get props => [patinElectricos];
}

class PatinElectricoError extends PatinElectricoState {
  final String message;

  const PatinElectricoError({required this.message});

  @override
  List<Object> get props => [message];
}