// ignore_for_file: prefer_const_constructors_in_immutables

part of 'history.bloc.dart';

abstract class HistoryTaskState extends Equatable {
  const HistoryTaskState();

  @override
  List<Object> get props => [];
}

class HistoryTaskInitial extends HistoryTaskState {}

class  HistoryTaskLoading extends HistoryTaskState {}

class HistoryTaskError extends HistoryTaskState {
  final String error;

  HistoryTaskError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetListTaskInactiveSuccessState extends HistoryTaskState {
  final List<TaskModel> list;
  GetListTaskInactiveSuccessState({required this.list});
  @override
  List<Object> get props => [list];
}
