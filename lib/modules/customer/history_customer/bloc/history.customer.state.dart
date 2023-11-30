// ignore_for_file: prefer_const_constructors_in_immutables

part of 'history.customer.bloc.dart';

abstract class HistoryCustomerState extends Equatable {
  const HistoryCustomerState();

  @override
  List<Object> get props => [];
}

class HistoryCustomerInitial extends HistoryCustomerState {}

class HistoryCustomerLoading extends HistoryCustomerState {}

class HistoryCustomerSuccessState extends HistoryCustomerState {
  final List<TicketResponseModel> list;
  HistoryCustomerSuccessState({required this.list});
  @override
  List<Object> get props => [list];
}

class HistoryCustomerError extends HistoryCustomerState {
  final String error;

  HistoryCustomerError({required this.error});

  @override
  List<Object> get props => [error];
}
