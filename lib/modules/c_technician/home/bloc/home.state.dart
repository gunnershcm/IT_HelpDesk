// ignore_for_file: prefer_const_constructors_in_immutables

part of 'home.bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class GetListTicketAssignSuccessState extends HomeState {
  final List<TicketResponseModel> list;
  GetListTicketAssignSuccessState({required this.list});
  @override
  List<Object> get props => [list];
}

class CareatedTaskSuccessState extends HomeState {}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetListTaskActiveSuccessState extends HomeState {
  final List<TaskModel> list;
  GetListTaskActiveSuccessState({required this.list});
  @override
  List<Object> get props => [list];
}

class EditTaskSuccessState extends HomeState {}

class EditTicketSuccessState extends HomeState {}