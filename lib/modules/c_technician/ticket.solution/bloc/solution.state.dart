// ignore_for_file: prefer_const_constructors_in_immutables

part of 'solution.bloc.dart';

abstract class TicketSolutionState extends Equatable {
  const TicketSolutionState();

  @override
  List<Object> get props => [];
}

class TicketSolutionInitial extends TicketSolutionState {}

class  TicketSolutionLoading extends TicketSolutionState {}

class TicketSolutionError extends TicketSolutionState {
  final String error;

  TicketSolutionError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetListSolutionState extends TicketSolutionState {
  final List<TicketSolutionModel> list;
  GetListSolutionState({required this.list});
  @override
  List<Object> get props => [list];
}

class CareateSolutionSuccessState extends TicketSolutionState {}
